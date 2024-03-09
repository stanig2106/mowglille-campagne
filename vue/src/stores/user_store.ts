import {defineStore} from "pinia";
import {computed, ref} from "vue";
import axios from "axios";
import {Rarity} from "@/views/collection/Chest.vue";

export const useUserStore = defineStore("user", () => {
  const loaded = ref(false)
  const id = ref(undefined as number | undefined)
  const publicToken = ref(undefined as string | undefined)
  const firstName = ref(undefined as string | undefined)
  const lastName = ref(undefined as string | undefined)
  const cursus = ref(undefined as string | undefined)

  const score = ref(undefined as number | undefined)
  const rank = ref(undefined as number | undefined)

  const pp = ref(undefined as string | null | undefined)
  const orr_pp = ref(undefined as string | null | undefined)
  const bg_pp = ref(undefined as string | null | undefined)

  const staffRoles = ref(undefined as string[] | undefined)

  const notification_preferences = ref(undefined as string[] | undefined)

  const chests = ref(undefined as Rarity[] | undefined)
  const collection_pieces = ref(undefined as number[] | undefined)

  const welcomed = ref(false)
  const score_seen = ref(false)

  const fullscreen_msg = ref(undefined as string | undefined | null)

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
    pp.value = user.pp
    orr_pp.value = user.orr_pp
    bg_pp.value = user.bg_pp

    chests.value = user.chests
    collection_pieces.value = user.collection_pieces

    notification_preferences.value = user.notification_preferences

    welcomed.value = user.welcomed
    score_seen.value = user.score_seen
    fullscreen_msg.value = user.fullscreen_msg
    return true
  }

  const name = computed(() => {
    if (!firstName.value || !lastName.value)
      return "";
    return `${firstName.value} ${lastName.value}`
  })

  return {
    loaded,
    id, publicToken,
    name, firstName, lastName, cursus,
    score, rank, staffRoles,
    pp, orr_pp, bg_pp,
    notification_preferences,
    chests, collection_pieces,
    welcomed, score_seen,
    fullscreen_msg,
    updateUser
  }
})
