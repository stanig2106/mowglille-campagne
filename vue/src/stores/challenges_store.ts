import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {Rarity} from "@/views/collection/Chest.vue";


export type Challenges = {
  id: number
  category: string
  name: string
  description: string
  score: number
  is_flash: boolean
  start_date: Date | null
  end_date: Date | null
  amount: number | null
}[]

export const useChallengesStore =
  defineStore("challenges", () => {
    const loaded = ref(false)
    const challenges = ref(undefined as Challenges | undefined)


    async function updateChallenges() {
      const response = await axios.get("/challenges")
      if (response.status !== 200)
        return false

      loaded.value = true
      challenges.value = response.data.challenges.map((challenge: any) => {
        if (challenge.start_date)
          challenge.start_date = new Date(challenge.start_date)
        if (challenge.end_date)
          challenge.end_date = new Date(challenge.end_date)
        return challenge
      })

      return true
    }


    return {
      loaded,
      challenges,
      updateChallenges
    }
  })
