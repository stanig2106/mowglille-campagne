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
  reward: ChestRewards
}[]

export const useChestsStore =
  defineStore("chests", () => {
    const loaded = ref(false)
    const chests = ref(undefined as Chests | undefined)


    async function updateChests() {
      const response = await axios.get("/chests")
      if (response.status !== 200)
        return false

      loaded.value = true
      chests.value = response.data.chests
      console.log(response.data)

      return true
    }


    return {
      loaded,
      chests,
      updateChests
    }
  })
