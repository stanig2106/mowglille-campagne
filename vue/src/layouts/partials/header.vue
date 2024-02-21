<script lang="ts" setup>

import useCable from "@/router/cable";
import {ref} from "vue";
import OfflineIndicator from "@/components/OfflineIndicator.vue";
import {useUserStore} from "@/stores/user_store";
import router from "@/router";
import {ProfileImage} from "@/utils/profile_pictures";

const has_notif = ref(true)

const props = defineProps<{
  back: string | undefined
  density: "normal" | "compact"
}>()

// useCable("NotificationChannel")

const userStore = useUserStore()
userStore.updateUser()

const goBackOrGoHome = () => window.history.length > 1 ?
  router.back() : router.replace("/");

</script>

<template>
  <div :class="{ 'h-16': density == 'normal', 'h-12': density == 'compact'}"
       class="bg-primary top-0 absolute w-full flex justify-between">

    <h1 v-if="back == undefined"
        class="h-full flex items-center text-3xl italic mt-0.5 ml-4">
      MOWG'LILLE
    </h1>

    <h1 v-else
        class="h-full flex items-center text-3xl italic mt-0.5">
      <v-btn icon rounded="lg" variant="text"
             @click="goBackOrGoHome">
        <v-icon size="32">
          mdi-arrow-left
        </v-icon>
      </v-btn>
      <div class="one-line pr-2">
        {{ back }}
      </div>
    </h1>

    <div v-if="back == null"
         class="h-full flex justify-end items-center mr-3 gap-2">
      <offline-indicator/>

      <v-btn icon variant="text" @click="$router.push('/profile')">
        <v-img :lazy-src="new ProfileImage(userStore.name).png()"
               :src="userStore.pp ?? new ProfileImage(userStore.name).png()"
               class="rounded-full bg-gray-200" style="width: 40px; height: 40px"/>
      </v-btn>


    </div>

  </div>
</template>

<style lang="scss">
h1 {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
}
</style>
