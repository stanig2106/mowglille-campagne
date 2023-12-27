<script lang="ts" setup>
import {inject, ref} from "vue";
import {offlineKey} from "@/router/keys";

const {offline} = inject(offlineKey)!



</script>

<template>
  <v-btn color="red" icon rounded="lg" variant="text" v-if="offline">
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
