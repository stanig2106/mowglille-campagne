import {defineStore} from "pinia";
import {ref} from "vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";

export type User = {
  publicToken: string
  name: string
  formation: string
}

export const useUsersStore = defineStore(
  "users", () => {
    const loaded = ref(false)
    const users = ref(undefined as User[] | undefined)


    async function updateUsers() {
      const response = await axios.get("/users")
      if (response.status !== 200)
        return false

      loaded.value = true
      users.value = response.data.users

      return true
    }


    return {
      loaded,
      users,
      updateUsers
    }
  })
