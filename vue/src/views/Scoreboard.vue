<script setup lang="ts">
import ScoreLine from "@/views/scoreboard/ScoreLine.vue";
</script>

<template>
  <div class="flex flex-col gap-4 mb-2">
    <ScoreLine class="rounded-2xl py-2 elevation-2"
               v-for="i in 10"
               :key="i"
               :class="i <= 3 ? 'bg-red-500 *:text-white' : 'bg-white'"/>
  </div>

  <v-bottom-navigation height="124" class="!fixed bottom-0 rounded-t-xl" elevation="18">
    <score-line/>
  </v-bottom-navigation>
</template>
