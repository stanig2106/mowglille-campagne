import {computed, ref} from "vue";
import axios, {AxiosError, AxiosRequestConfig} from "axios";
import {useOnlineJobsStore} from "@/stores/online_jobs_store";
import useCable from "@/router/cable";


const offline = ref(false);

function updateOffline(value: boolean) {
  offline.value = value;
}

export function useOffline() {
  return {
    offline,
    updateOffline
  };
}

export function useOnline() {
  return {
    online: computed(() => !offline.value),
    updateOnline: (value: boolean) => updateOffline(!value)
  };
}


export function doItOnline(axiosQuery: AxiosRequestConfig, description: { title: string, message: string } | null, id: string | null = null) {
  const onlineJobs = useOnlineJobsStore().onlineJobs

  if (id !== null)
    onlineJobs.splice(onlineJobs.findIndex(job => job.id === id), 1);

  onlineJobs.push({
    description, id,
    request: {
      ...axiosQuery,
      data: {
        ...axiosQuery.data,
        request_id: Math.random().toString(36).substring(7)
      }
    }
  });

  if (!offline.value)
    return doOnlineJobs()
  return Promise.resolve();
}


export async function doOnlineJobs() {
  if (offline.value) return;

  const onlineJobs = useOnlineJobsStore().onlineJobs

  const failedJobs: typeof onlineJobs = [];
  for await (const job of onlineJobs) {
    await axios(job.request).catch((error: AxiosError) => {
      if (error.code === 'ECONNABORTED' || error.code === 'ERR_NETWORK')
        return failedJobs.push(job);
    })
  }
  onlineJobs.length = 0;
  failedJobs.forEach(job => onlineJobs.push(job));
}

export function startOnlineJobs() {
  setInterval(doOnlineJobs, 5000);

  useCable('OfflineChannel', {
    connected() {
      console.log('connected');
      updateOffline(false);
    },
    disconnected() {
      console.log('disconnected');
      updateOffline(true);
    }
  }, true);
}
