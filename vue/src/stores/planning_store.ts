import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";

export type Planning = {
  content: {
    content: string,
    background_color: { red: number, green: number, blue: number },
    link: string,
  }
  day: string,
  start_hour: number,
  start_minute: number,
  duration: number,
}

export const usePlanningStore = defineStore(
  "planning", () => {
    const loaded = ref(false)
    const sheet_link = ref(null as string | null)

    const planning = ref([] as Planning[])
    const days = ref([] as {
      date: string,
      dayOfWeek: string
    }[])

    async function updatePlanning() {
      const response = await axios.get("/planning")
      if (response.status !== 200)
        return false

      loaded.value = true

      sheet_link.value = response.data.sheet_link || null
      planning.value = response.data.planning
      days.value = response.data.days

      return true
    }

    return {
      loaded,
      planning, days,
      sheet_link,
      updatePlanning
    }
  })
