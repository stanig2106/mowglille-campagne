import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";


export const useManagePlanningStore = defineStore(
  "manage_planning", () => {
    const loaded = ref(false)
    const sheet_link = ref(null as string | null)
    const associations = ref([] as { letter: string, name: string }[])


    async function updateManagePlanning() {
      const response = await axios.get("/manage_planning")
      if (response.status !== 200)
        return false

      loaded.value = true

      sheet_link.value = response.data.sheet_link || null
      associations.value = response.data.associations

      return true
    }

    return {
      loaded,
      sheet_link,
      associations,
      updateManagePlanning
    }
  })
