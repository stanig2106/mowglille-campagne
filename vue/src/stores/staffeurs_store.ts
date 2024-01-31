import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";

export type Staffeurs = {
  publicToken: string
  name: string
  roles: typeof roles[number][]
}[]

export const useStaffeursStore = defineStore(
  "staffers", () => {
    const loaded = ref(false)
    const staffers = ref(undefined as Staffeurs | undefined)


    async function updateStaffeurs() {
      const response = await axios.get("/staffers")
      if (response.status !== 200)
        return false

      loaded.value = true
      staffers.value = response.data.staffers

      return true
    }


    return {
      loaded,
      staffers,
      updateStaffeurs
    }
  })
