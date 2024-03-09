<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {inject, nextTick, ref, watch} from "vue";
import router from "@/router";
import FindUser from "@/components/FindUser.vue";
import {User} from "@/stores/users_store";
import Chest, {Rarity} from "@/views/collection/Chest.vue";
import {chestRarities} from "@/views/collection/chest";
import axios from "axios";
import {doItOnline, useOnline} from "@/router/offline";
import {useChallengesStore} from "@/stores/challenges_store";
import {informShowKey} from "@/router/keys";

const currentUser = useUserStore()
currentUser.updateUser()

const challengesStore = useChallengesStore()
challengesStore.updateChallenges()

if (!currentUser.staffRoles?.includes("CHALLENGE_VALIDATION"))
  router.replace("/")

const user = ref(null as User | null)
const challenge_id = ref(null as number | null)

const informShow = inject(informShowKey)!

watch(user, async () => {
  if (!user.value)
    return


  await axios.post("/challenges/validate/" + challenge_id.value, {user: user.value.publicToken})
    .then(({data}) => {
      if (data.error)
        informShow("Erreur", data.error)
      else
        informShow("Succès", "Défi validé")
    })
  user.value = null
})

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">

    {{ challenge_id }}
    <div>
      <v-select v-model="challenge_id" :items="challengesStore.challenges"
                class="w-full" dense item-title="name" item-value="id" label="name"/>
    </div>
    <div>
      <find-user :key="user?.publicToken" v-model="user" class="w-full h-full" hide-cancel
                 variant="text"/>
    </div>

  </div>
</template>
