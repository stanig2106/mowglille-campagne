import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";


export const usePlanningStore = defineStore(
  "planning", () => {
    const loaded = ref(false)
    const sheet_link = ref(null as string | null)


    async function updatePlanning() {
      const response = await axios.get("/planning")
      if (response.status !== 200)
        return false

      loaded.value = true

      sheet_link.value = response.data.sheet_link || null

      return true
    }

    return {
      loaded,
      sheet_link,
      updatePlanning
    }
  })
