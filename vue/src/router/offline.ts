import {computed, ref} from "vue";
import {Axios, AxiosError} from "axios";


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


// TODO: Use a store ?
// true = done
const onlineJobs: (() => boolean | void)[] = [];

export function doItOnline(job: () => boolean | void) {
  onlineJobs.push(job);
}

function doOnlineJobs() {
  if (offline.value) return;
  const failedJobs: typeof onlineJobs = [];
  onlineJobs.forEach(job => {
    try {
      if (job() === false) failedJobs.push(job);
    } catch (e) {
      if (e instanceof AxiosError && (e.code === 'ECONNABORTED' || e.code === 'ERR_NETWORK'))
        failedJobs.push(job);
      else
        throw e;
    }
  })
  onlineJobs.length = 0;
  failedJobs.forEach(job => onlineJobs.push(job));
}

export function startOnlineJobs() {
  setInterval(doOnlineJobs, 5000);
}
