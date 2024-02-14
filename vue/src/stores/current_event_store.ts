import {defineStore} from "pinia";
import {computed, ref} from "vue";
import axios from "axios";
import {Rarity} from "@/views/collection/Chest.vue";


export type CurrentEvent = {
  internalId: string
  name: string
  type: string
  startDate: Date
  endDate: Date
  location: string
  description: string
  menu: MenuItem[]
  activities: Activity[]
}

export type MenuItem = {
  id: number
  name: string
  src: string
  type: string
  vg: boolean
}

export type Activity = {
  internalId: string
  name: string
  internalDescription: string
  description: string
  startDate: Date | null // null means the activity duration is the event duration
  endDate: Date | null
  location: string | null // null means the activity location is the event location
  activityRewards: ActivityReward[]
}

export type ActivityReward = {
  id: number
  name: string
  internalDescription: string
  chest: Rarity | null
  score: number
}

export const useCurrentEventStore = defineStore(
  "current_event", () => {
    const loaded = ref(false)
    const current_event = ref(undefined as CurrentEvent | undefined)


    async function updateCurrentEvent() {
      const response = await axios.get("/current_event", {
        params: {known: current_event.value?.internalId}
      })

      if (response.status !== 200)
        return false

      loaded.value = true

      if (response.data.unchanged)
        return true

      current_event.value = {
        ...response.data,
        startDate: new Date(response.data.startDate),
        endDate: new Date(response.data.endDate),
        activities: response.data.activities.map((activity: any) => {
          return {
            ...activity,
            startDate: activity.startDate ? new Date(activity.startDate) : null,
            endDate: activity.endDate ? new Date(activity.endDate) : null,
          }
        })
      }

      return true
    }

    const started = computed(() => {
      return current_event.value && current_event.value?.startDate <= new Date()
    })

    return {
      loaded,
      current_event,
      started,
      updateCurrentEvent
    }
  })
