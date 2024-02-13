<script lang="ts" setup>

import EventAction from "@/views/home/event/EventAction.vue";
import router from "@/router";

const props = defineProps<{
  event_type: string
  event_name: string
  background_url: string
}>()

</script>

<template>
  <div :style="{ backgroundImage: `url(${background_url})` }"
       class="flex flex-col gap-2 px-4 py-2 pb-4 bg-green-600 bg-opacity-90 rounded-2xl elevation-2"
       style=" background-size: cover; background-position: center; background-blend-mode: color;
            background-color: rgba(0, 0, 0, 0.7);">
    <div class="flex flex-col">
      <h2 class="text-gray-200 text-lg font-bold flex justify-between">
        <div>
          Actuellement :
        </div>
        <div>
          {{ props.event_type }}
        </div>
      </h2>
      <h3 class="text-white text-5xl text-uppercase">
        {{ props.event_name }}
      </h3>
    </div>

    <event-action icon="mdi-food" subtitle="Voir le menu" title="Un petit creux ?"
                  @click="router.push('menu')"/>
    <event-action icon="mdi-map" subtitle="Regarde la carte" title="Perdu ?"/>
    <event-action icon="mdi-music-note-plus" subtitle="Propose le tiens !" title="Pas ouf le son ?"/>
    <event-action icon="mdi-chat" subtitle="Ouvre le chat" title="Discute de l'évent"/>
  </div>

</template>
