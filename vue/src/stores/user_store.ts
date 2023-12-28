import {defineStore} from "pinia";
import {computed, ref} from "vue";
import axios from "axios";

export const useUserStore = defineStore("user", () => {
  const loaded = ref(false)
  const id = ref(undefined)
  const publicToken = ref(undefined)
  const firstName = ref(undefined)
  const lastName = ref(undefined)

  const score = ref(undefined as number | undefined)
  const rank = ref(undefined as number | undefined)

  async function updateUser() {
    const response = await axios.get("/user")
    if (response.status !== 200)
      return false

    loaded.value = true
    const user = response.data
    id.value = user.id
    publicToken.value = user.public_token
    firstName.value = user.first_name
    lastName.value = user.last_name
    score.value = user.score
    rank.value = user.rank
    return true
  }

  const name = computed(() => `${firstName.value} ${lastName.value}`)


  return {
    loaded,
    id, publicToken,
    name, firstName, lastName,
    score, rank,
    updateUser
  }
})
