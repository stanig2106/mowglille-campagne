<script setup lang="ts">
import ScoreLine from "@/views/scoreDetails/ScoreLine.vue";
import CurrentScore from "@/views/scoreboard/ScoreLine.vue";
</script>

<template>
  <div class="flex flex-col gap-4 mb-2">
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
    <score-line class="rounded-2xl py-2 bg-white elevation-2"/>
  </div>

  <v-bottom-navigation height="124" class="!fixed bottom-0 rounded-t-xl" elevation="18">
    <current-score/>
  </v-bottom-navigation>
</template>
