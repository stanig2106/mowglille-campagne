import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";
import {Rarity} from "@/views/collection/Chest.vue";


export type Event = {
  internalId: string
  name: string
  type: string
  startDate: Date
  endDate: Date
  location: string
  description: string
  activities: Activity[]
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
  name: string
  internalDescription: string
  chest: Rarity
  score: number
}

export const useEventsStore = defineStore(
  "events", () => {
    const loaded = ref(false)
    const events = ref([] as Event[])


    async function updateEvents() {
      const response = await axios.get("/events")
      if (response.status !== 200)
        return false

      loaded.value = true
      events.value = response.data.map((event: any) => {
        return {
          ...event,
          startDate: new Date(event.startDate),
          endDate: new Date(event.endDate),
        }
      })

      return true
    }


    return {
      loaded,
      events,
      updateEvents
    }
  })
