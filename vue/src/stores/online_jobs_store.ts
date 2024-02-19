import {defineStore} from "pinia";
import {ref} from "vue";
import axios, {AxiosRequestConfig} from "axios";

export const useOnlineJobsStore = defineStore(
  "online_jobs", () => {
    const onlineJobs = ref([] as {
      description: { title: string, message: string } | null,
      request: AxiosRequestConfig
    }[])

    return {
      onlineJobs,
    }
  })
