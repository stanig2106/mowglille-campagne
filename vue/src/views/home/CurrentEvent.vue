<script lang="ts" setup>

import EventAction from "@/views/home/event/EventAction.vue";
import router from "@/router";
import {useCurrentEventStore} from "@/stores/current_event_store";
import {typeToString} from "@/utils/event";
import {computedWithControl} from "@vueuse/core";
import {storeToRefs} from "pinia";

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

<!--:style="{ backgroundImage: `url(${background_url})` }"-->
<template>
  <div v-if="currentEvent"
       :style="{ 'background-color': currentEventStore.started ? '#D6646D' : '#355b17' }"
       class="flex flex-col gap-2 px-4 py-2 pb-4 bg-green-600 bg-opacity-90 rounded-2xl elevation-2"
       style=" background-size: cover; background-position: center; background-blend-mode: color;">
    <div class="flex flex-col mb-4">
      <div class="text-gray-200 text-lg font-bold flex justify-between">
        <div v-if="currentEventStore.started || timeToNext != '...'">
          {{ currentEventStore.started ? "Actuellement :" : ("Prochainement (" + timeToNext + ") ") }}
        </div>
        <div v-else>
          Prochainement
        </div>
        <div>
          {{ typeToString(currentEvent.type) }}
        </div>
      </div>
      <h3 class="text-white text-5xl text-uppercase mt-4">
        {{ currentEvent.name }}
      </h3>
    </div>

    <event-action v-if="currentEvent.menu.length > 0" icon="mdi-food" subtitle="Voir le menu"
                  title="Un petit creux ?" @click="router.push('menu')"/>
    <event-action v-if="currentEvent.type == 'HOT'" disabled
                  icon="mdi-car-hatchback" subtitle="Faites vous livrer !"
                  title="Une envie ?" @click="router.push('delivery')"/>
    <event-action :disabled="currentEvent.type == 'HOT'" icon="mdi-dots-horizontal"
                  subtitle="Lire la com" title="Besoin d'infos ?"
                  @click="router.push('event_info')"/>

    <div class="flex justify-end text-white mt-2">
      Lieu : {{ currentEvent.location }}
    </div>
  </div>

</template>
