import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";

export type User = {
  publicToken: string
  firstName: string
  lastName: string
  score: number
  cursus: string
}

export const useUsersStore = defineStore(
  "users", () => {
    const loaded = ref(false)
    const users = ref([] as User[])


    async function updateUsers() {
      const response = await axios.get("/users",
        {params: {known_count: users.value.length}})

      if (response.status !== 200)
        return false

      loaded.value = true

      if (response.data.unchanged)
        return true

      users.value = response.data

      return true
    }


    return {
      loaded,
      users,
      updateUsers
    }
  })
