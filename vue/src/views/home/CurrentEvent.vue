<script lang="ts" setup>

import EventAction from "@/views/home/event/EventAction.vue";

const props = defineProps<{
  event_name: string
}>()

</script>

<template>
  <div class="flex flex-col gap-2 px-4 py-2 bg-red-600 bg-opacity-90 rounded-2xl elevation-2">
    <div class="flex flex-col">
      <h2 class="text-gray-200 text-lg font-bold">
        Actuellement :
      </h2>
      <h3 class="text-white text-5xl text-uppercase">
        {{ props.event_name }}
      </h3>
    </div>

    <event-action icon="mdi-food" subtitle="Voir le menu" title="Un petit creux ?"/>
    <event-action icon="mdi-map" subtitle="Regarde la carte" title="Perdu ?"/>
    <event-action icon="mdi-music-note-plus" subtitle="Propose le tiens !" title="Pas ouf le son ?"/>
    <event-action icon="mdi-chat" subtitle="Ouvre le chat" title="Discute de l'évent"/>
  </div>

</template>
