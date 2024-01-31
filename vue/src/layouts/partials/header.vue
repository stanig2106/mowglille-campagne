<script lang="ts" setup>


import useCable from "@/router/cable";
import fake_profile from "@/assets/fake/profile.jpeg"
import {ref} from "vue";
import OfflineIndicator from "@/components/OfflineIndicator.vue";
import {useScreenSafeArea} from "@vueuse/core";

const has_notif = ref(true)

const props = defineProps<{
  back: string | undefined
  density: "normal" | "compact"
}>()

// useCable("NotificationChannel")

const safeArea = useScreenSafeArea()

</script>

<template>
  <div :class="{ 'h-16': density == 'normal', 'h-12': density == 'compact'}"
       class="bg-primary top-0 absolute w-full flex justify-between"
       :style="{paddingTop: safeArea.top + 'px'}"
  >

    <h1 v-if="back == undefined"
        class="h-full flex items-center text-3xl italic mt-0.5 ml-4">
      MOWG'LILLE {{ safeArea.top }}
    </h1>

    <h1 v-else
        class="h-full flex items-center text-3xl italic mt-0.5">
      <v-btn icon rounded="lg" variant="text"
             @click="$router.go(-1)">
        <v-icon size="32">
          mdi-arrow-left
        </v-icon>
      </v-btn>
      {{ back }}
    </h1>

    <div v-if="back == null"
         class="h-full flex justify-end items-center mr-3 gap-2">
      <offline-indicator/>

      <v-btn icon variant="text" @click="$router.push('/profile')">
        <v-img :src="fake_profile" class="rounded-full"
               style="width: 40px; height: 40px"/>
      </v-btn>


    </div>

  </div>
</template>

<style lang="scss">
h1 {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
}
</style>
