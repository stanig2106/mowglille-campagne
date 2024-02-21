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
  if (currentEvent.value.startDate.getTime == undefined)
    return '...'
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
  <!--  <div :style="{ backgroundImage: `url(${background_url})` }"-->
  <div
    v-if="currentEvent"
    class="flex flex-col gap-2 px-4 py-2 pb-4 bg-green-600 bg-opacity-90 rounded-2xl elevation-2"
    style=" background-size: cover; background-position: center; background-blend-mode: color;
            background-color: #D6646D">
    <div class="flex flex-col mb-4">
      <h2 class="text-gray-200 text-lg font-bold flex justify-between">
        <div>
          {{ currentEventStore.started ? "Actuellement :" : ("Prochainement (" + timeToNext + ") ") }}
        </div>
        <div>
          {{ typeToString(currentEvent.type) }}
        </div>
      </h2>
      <h3 class="text-white text-5xl text-uppercase">
        {{ currentEvent.name }}
      </h3>
    </div>

    <event-action v-if="currentEvent.menu.length > 0" icon="mdi-food" subtitle="Voir le menu"
                  title="Un petit creux ?" @click="router.push('menu')"/>
    <event-action icon="mdi-chat" subtitle="Ouvre le chat" title="Discute de l'évent"
                  @click="router.push('chat')"/>
    <event-action icon="mdi-dots-horizontal" subtitle="En savoir plus" title="Une question ?"/>
    <!--    <event-action icon="mdi-music-note-plus" subtitle="Propose le tiens !" title="Pas ouf le son ?" class="opacity-0"/>-->
  </div>

</template>
