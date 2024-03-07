import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {Rarity} from "@/views/collection/Chest.vue";

export type ChestRewards = ({
  type: "piece"
  rarity: "rare" | "epic" | "legendary"
  id: number
  new?: boolean
} | {
  type: "score"
  amount: number
})[]

export type Chests = {
  id: number,
  rarity: Rarity,
}[]

export type Rewards = {
  rare: number[],
  epic: number[],
  legendary: number[]
}

export const useChestsStore =
  defineStore("chests", () => {
    const loaded = ref(false)
    const chests = ref(undefined as Chests | undefined)
    const rewards = ref(undefined as Rewards | undefined)
    const collections = ref(undefined as number[] | undefined)
    const winner = ref(undefined as boolean | string | undefined)

    async function updateChests() {
      const response = await axios.get("/chests")
      if (response.status !== 200)
        return false

      loaded.value = true
      chests.value = response.data.chests
      rewards.value = response.data.rewards
      collections.value = response.data.collections
      winner.value = response.data.winner

      return true
    }


    return {
      loaded,
      chests,
      rewards,
      collections,
      winner,
      updateChests
    }
  })
