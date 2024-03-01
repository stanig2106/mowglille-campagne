<script setup lang="ts">

import {ref} from 'vue'

const page = ref(1)

const titles = [
  "Défis flash",
  "Défis bzzz bzzz",
  "Défis mielleux au miel",
  "Défis de zinzin",
]

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <div class="flex justify-between items-center mb-4">
      <v-btn icon @click="page--" rounded="lg" :disabled="page == 0">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <h3>
        {{ titles[page] }}
      </h3>
      <v-btn icon @click="page++" rounded="lg" :disabled="page == titles.length - 1">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </div>
    <v-carousel :show-arrows="false" hide-delimiters v-model="page" :continuous="false"
                class="flex-grow >:!h-full">
      <v-carousel-item v-for="index in titles.length" :key="index">
        <div class="h-full text-xl text-center mt-4">
          Aucun défi pour le moment, revenez plus tard !
        </div>
      </v-carousel-item>
    </v-carousel>

  </div>
</template>

