import {defineStore} from "pinia";
import {computed, ref} from "vue";
import axios from "axios";

export const useUserStore = defineStore("user", () => {
  const loaded = ref(false)
  const id = ref(undefined as number | undefined)
  const publicToken = ref(undefined as string | undefined)
  const firstName = ref(undefined as string | undefined)
  const lastName = ref(undefined as string | undefined)
  const cursus = ref(undefined as string | undefined)

  const score = ref(undefined as number | undefined)
  const rank = ref(undefined as number | undefined)

  const staffRoles = ref(undefined as string[] | undefined)

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
    cursus.value = user.cursus

    score.value = user.score
    rank.value = user.rank
    staffRoles.value = user.staff_roles
    return true
  }

  const name = computed(() => `${firstName.value} ${lastName.value}`)


  return {
    loaded,
    id, publicToken,
    name, firstName, lastName, cursus,
    score, rank, staffRoles,
    updateUser
  }
})
