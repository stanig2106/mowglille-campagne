<script lang="ts" setup>

import Score from "@/views/home/Score.vue";
import NextEvent from "@/views/home/NextEvent.vue";
import CurrentEvent from "@/views/home/CurrentEvent.vue";
</script>

<template>
  <div class="flex flex-col gap-4">
    <Score/>
    <CurrentEvent event_name="Le Livre de la Jungle"/>
  </div>
</template>


