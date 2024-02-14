<script lang="ts" setup>

import EventAction from "@/views/home/event/EventAction.vue";
import router from "@/router";
import {useCurrentEventStore} from "@/stores/current_event_store";
import {typeToString} from "@/utils/event";
import {computedWithControl} from "@vueuse/core";
import {storeToRefs} from "pinia";

const props = defineProps<{
  event_type: string
  event_name: string
  background_url: string
}>()

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()
const {current_event: currentEvent} = storeToRefs(currentEventStore)

const timeToNext = computedWithControl(() => void 0, () => {
  if (currentEvent.value == undefined)
    return "0 s"
  const res = currentEvent.value.startDate.getTime() - new Date().getTime()
  if (res < 0)
    return "0 s"
  const seconds = Math.floor(res / 1000)
  const minutes = Math.floor(seconds / 60)
  const hours = Math.floor(minutes / 60)
  const days = Math.floor(hours / 24)
  if (days > 0)
    return days + " j " + (hours % 24) + " h"
  if (hours > 0)
    return hours + " h " + (minutes % 60) + " m"
  if (minutes > 0)
    return minutes + " m " + (seconds % 60) + " s"
  return seconds + " s"
})

setInterval(timeToNext.trigger, 1000)

</script>

<template>
  <div :style="{ backgroundImage: `url(${background_url})` }"
       class="flex flex-col gap-2 px-4 py-2 pb-4 bg-green-600 bg-opacity-90 rounded-2xl elevation-2"
       style=" background-size: cover; background-position: center; background-blend-mode: color;
            background-color: rgba(0, 0, 0, 0.7);" v-if="currentEvent">
    <div class="flex flex-col">
      <h2 class="text-gray-200 text-lg font-bold flex justify-between">
        <div>
          {{ currentEventStore.started ? "Actuellement :" : "Prochainement :" }}
        </div>
        <div>
          {{ typeToString(currentEvent.type) }}
        </div>
      </h2>
      <h3 class="text-white text-5xl text-uppercase">
        {{ currentEvent.name }}
      </h3>
    </div>

    <event-action icon="mdi-food" subtitle="Voir le menu" title="Un petit creux ?"
                  @click="router.push('menu')"/>
    <event-action icon="mdi-map" subtitle="Regarde la carte" title="Perdu ?"/>
    <event-action icon="mdi-music-note-plus" subtitle="Propose le tiens !" title="Pas ouf le son ?"/>
    <event-action icon="mdi-chat" subtitle="Ouvre le chat" title="Discute de l'évent"/>
  </div>

</template>
