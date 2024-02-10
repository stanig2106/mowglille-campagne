import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";

//   create_table "events", force: :cascade do |t|
//     t.string "internal_id"
//     t.string "name"
//     t.string "type"
//     t.date "start_date"
//     t.date "end_date"
//     t.string "location"
//     t.text "description"
//     t.datetime "created_at", null: false
//     t.datetime "updated_at", null: false
//   end

export type Event = {
  internalId: string
  name: string
  type: string
  startDate: Date
  endDate: Date
  location: string
  description: string
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
          internalId: event.internal_id,
          name: event.name,
          type: event.type,
          startDate: new Date(event.start_date),
          endDate: new Date(event.end_date),
          location: event.location,
          description: event.description
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
