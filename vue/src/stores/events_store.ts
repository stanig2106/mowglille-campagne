import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
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
  id: number
  name: string
  internalDescription: string
  chest: Rarity | null
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
          activities: event.activities.map((activity: any) => {
            return {
              ...activity,
              startDate: activity.startDate ? new Date(activity.startDate) : null,
              endDate: activity.endDate ? new Date(activity.endDate) : null,
            }
          })
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
