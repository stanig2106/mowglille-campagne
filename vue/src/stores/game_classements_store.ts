import {defineStore} from "pinia";
import {reactive} from "vue";
import axios from "axios";

export type GameScoreboard = {
  date: Date
  rank: number
  score: number
  name: string
  pp: string | null
  you: boolean
}[]

export const useGameScoreboardStore = defineStore("scoreboard", () => {
  const scoreboards = reactive({} as Record<string, GameScoreboard>)


  async function updateScoreboard(game_name: string) {
    const response = await axios.get("/games/scoreboard", {
      params: {game_name}
    })

    if (response.status !== 200)
      return false

    scoreboards[game_name] = response.data.map((score: any) => ({
      ...score,
      date: new Date(score.date),
    }))

    return true
  }

  return {
    scoreboards,
    updateScoreboard
  }
})
