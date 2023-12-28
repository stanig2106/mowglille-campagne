import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";

export type Scoreboard = {
  rank: number
  score: number
  name: string
}[]

export const useScoreboardStore = defineStore("scoreboard", () => {
  const loaded = ref(false)
  const scoreboard = ref(undefined as Scoreboard | undefined)


  async function updateScoreboard() {
    const response = await axios.get("/scoreboard")
    if (response.status !== 200)
      return false

    loaded.value = true
    scoreboard.value = response.data.scoreboard

    return true
  }


  return {
    loaded,
    scoreboard,
    updateScoreboard
  }
})
