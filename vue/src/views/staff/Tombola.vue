<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {inject, nextTick, ref, watch} from "vue";
import router from "@/router";
import FindUser from "@/components/FindUser.vue";
import {User} from "@/stores/users_store";
import axios from "axios";
import {informShowKey} from "@/router/keys";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("SCORE"))
  router.replace("/")

const user = ref(null as User | null)

const informShow = inject(informShowKey)!

watch(user, async () => {
  if (!user.value)
    return
  
  await axios.post("/staff/tombola/give", {user: user.value.publicToken})
    .then(({data}) => {
      if (data.error)
        informShow("Erreur", data.error)
      else
        informShow("Succès", "Le ticket a été donné")
    })
  user.value = null
})

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">

    <div>
      <find-user :key="user?.publicToken" v-model="user" class="w-full h-full" hide-cancel
                 variant="text"/>
    </div>

  </div>
</template>
