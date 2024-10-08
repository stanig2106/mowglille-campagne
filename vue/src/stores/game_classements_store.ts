import {defineStore} from "pinia";
import {reactive} from "vue";
import axios from "axios";

export type GameScoreboard = {
  id: number
  date: Date
  rank: number
  score: number
  name: string
  pp: string | null
  you: boolean
  tries: number
  average: number
  congratulated: boolean
}[]

export const useGameScoreboardStore = defineStore(
  "game_scoreboard", () => {
    const scoreboards = reactive({} as Record<string, GameScoreboard>)
    const personalScore = reactive({} as Record<string, GameScoreboard[number] | null>)


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

      personalScore[game_name] = scoreboards[game_name]
        .find(score => score.you) ?? null


      return true
    }

    return {
      scoreboards,
      personalScore,
      updateScoreboard
    }
  })
