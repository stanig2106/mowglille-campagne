import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";

export type ScoreDetails = {}[]

export const useScoreDetailsStore = defineStore("score_details", () => {
  const loaded = ref(false)
  const scoreDetails = ref(undefined as ScoreDetails | undefined)


  async function updateScoreDetails() {
    const response = await axios.get("/score_details")
    if (response.status !== 200)
      return false

    loaded.value = true
    scoreDetails.value = response.data.score_details

    return true
  }


  return {
    loaded,
    scoreDetails,
    updateScoreDetails
  }
})
