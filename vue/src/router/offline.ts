import {computed, ref} from "vue";
import axios, {Axios, AxiosError, AxiosRequestConfig} from "axios";
import {useOnlineJobsStore} from "@/stores/online_jobs_store";


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


export function doItOnline(axiosQuery: AxiosRequestConfig, description: { title: string, message: string }) {
  const onlineJobs = useOnlineJobsStore().onlineJobs

  onlineJobs.push({description, request: axiosQuery});
}


export async function doOnlineJobs() {
  await axios.get('/version')
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
}
