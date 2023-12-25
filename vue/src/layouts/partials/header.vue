<script lang="ts" setup>


import useCable from "@/router/cable";

const props = defineProps<{
  back: string | null
}>()

useCable("NotificationChannel")

function openInstagram() {
  window.open("https://www.instagram.com/mowglille/", "_blank")
}

function openFacebook() {
  window.open("https://www.facebook.com/mowglille", "_blank")
}


</script>

<template>
  <div class="bg-primary top-0 absolute h-16 w-full
              flex justify-between">

    <h1 v-if="back == null"
        class="h-full flex items-center text-3xl italic mt-0.5 ml-4">
      MOWG'LILLE
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
         class="h-full flex justify-end items-center mr-2">
      <v-btn icon rounded="lg" variant="text"
             @click="openInstagram">
        <v-icon size="32">
          mdi-instagram
        </v-icon>
      </v-btn>

      <v-btn icon rounded="lg" variant="text"
             @click="openFacebook">
        <v-icon size="32">
          mdi-facebook
        </v-icon>
      </v-btn>

      <!--      notifications s-->

      <v-btn icon rounded="lg" variant="text">
        <v-badge v-if="true" color="red" dot>
          <v-icon size="32">
            mdi-bell
          </v-icon>
        </v-badge>

        <v-icon v-else size="32">
          mdi-bell
        </v-icon>

        <v-menu activator="parent" close-on-back scrim="#00000000">
          <v-list density="compact">
            <v-list-subheader>Notifications</v-list-subheader>
            <v-list-item value>
              <v-list-item-title>
                <div class="flex items-center justify-between">
                  Test
                  <v-badge v-if="true" color="red" dot inline/>
                </div>
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-btn>


    </div>

  </div>
  <div id="header-clip" class="bg-primary top-0 z-10 sticky h-1"/>
</template>

<style lang="scss">
h1 {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
}
</style>
