<script lang="ts" setup>
import {useOffline} from "@/router/offline";

const {offline} = useOffline()
</script>

<template>
  <v-btn v-if="offline" color="red" icon rounded="lg" variant="text">
    <v-icon>mdi-wifi-off</v-icon>
    <v-menu activator="parent">
      <div class="relative bg-red-800 rounded-2xl p-4 pr-6
        elevation-2 text-md text-white">
        Vous êtes hors ligne!
        Les fonctionnalités de l'application sont
        limitées et les données peuvent être obsolètes.
        <div class="absolute top-0 left-0 w-full h-full overflow-hidden rounded-2xl">
          <v-progress-linear
            :active="true"
            :indeterminate="true"
            absolute
            color="white"
            location="bottom"
          ></v-progress-linear>
        </div>
      </div>
    </v-menu>
  </v-btn>
</template>

<style lang="scss">
.v-progress-linear__indeterminate {
  animation-duration: 3.2s !important;
}

.v-progress-linear__indeterminate.long {
  opacity: 0;
}

</style>
