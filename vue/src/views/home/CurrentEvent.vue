<script lang="ts" setup>

import EventAction from "@/views/home/event/EventAction.vue";
import router from "@/router";
import {useCurrentEventStore} from "@/stores/current_event_store";
import {dayOfWeekToString, typeToString} from "@/utils/event";
import {computedWithControl} from "@vueuse/core";
import {storeToRefs} from "pinia";
import {dateToS} from "../games/safariSprint/core/utils";

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()
const {current_event: currentEvent} = storeToRefs(currentEventStore)

const timeToNext = computedWithControl(() => void 0, () => {
  if (currentEvent.value == undefined)
    return "0s"
  if (currentEvent.value.startDate.getTime == undefined)
    return ''
  const res = currentEvent.value.startDate.getTime() - new Date().getTime()
  if (res < 0)
    return "0s "
  const seconds = Math.floor(res / 1000)
  const minutes = Math.floor(seconds / 60)
  const hours = Math.floor(minutes / 60)
  const days = Math.floor(hours / 24)
  if (days > 0)
    return days + "j " + (hours % 24) + "h "
  if (hours > 0)
    return hours + "h " + (minutes % 60) + "m "
  if (minutes > 0)
    return minutes + "m " + (seconds % 60) + "s "
  return seconds + "s"
})

setInterval(timeToNext.trigger, 1000)

setInterval(currentEventStore.updateCurrentEvent, 1000 * 5) // Update every 5 seconds

function open_form() {
  window.open("https://forms.gle/MTEeHUNuL2ay67mz9")
}


</script>

<!--:style="{ backgroundImage: `url(${background_url})` }"-->
<template>
  <div v-if="currentEvent"
       :style="{ 'background-color': currentEventStore.started ? '#D6646D' : '#355b17' }"
       class="flex flex-col gap-2 px-4 py-2 pb-4 bg-green-600 bg-opacity-90 rounded-2xl elevation-2"
       style=" background-size: cover; background-position: center; background-blend-mode: color;">
    <div class="flex flex-col mb-4">
      <div class="text-gray-200 text-lg font-bold">
        {{ currentEventStore.started ? "Actuellement :" : "Prochainement" }} {{ currentEventStore.started ? "" : timeToNext }}
      </div>
      <h3 class="text-white text-5xl text-uppercase mt-4">
        {{ currentEvent.name }}
      </h3>
    </div>

    <event-action v-if="currentEvent.menu.length > 0" icon="mdi-food" subtitle="Voir le menu"
                  title="Un petit creux ?" @click="router.push('menu')"/>
    <event-action v-if="currentEvent.type == 'DHO'" :disabled="!currentEventStore.started"
                      icon="mdi-car-hatchback" link="https://forms.gle/iT8joUShuDrhwP4u9"
                      subtitle="Faites vous livrer !" title="Une envie ?"/>
    <event-action v-if="currentEvent.internalId != 'DP' && currentEvent.internalId != '10'"
                  icon="mdi-counter" subtitle="Voir les jeux" title="Envie de miel ?"
                  @click="router.push('activities')"/>
    <event-action v-if="currentEvent.internalId != 'DP'" icon="mdi-dots-horizontal"
                  subtitle="Lire la com" title="Besoin d'infos ?"
                  @click="router.push('event_info')"/>

    <event-action v-if="currentEvent.internalId == 'DP'" icon="mdi-dots-horizontal"
                  subtitle="Voir le programme" title="Une question ?"
                  @click="router.push('program')"/>

    <event-action v-if="currentEvent.internalId == '13'" icon="mdi-ticket"
                  subtitle="Tentez votre chance" title="Tombola"
                  @click="router.push('tombola')"/>



    <div class="flex justify-end text-white mt-2">
      Lieu : {{ currentEvent.location }}
    </div>
    <div v-if="currentEvent.startDate?.getDay && currentEvent.endDate" class="text-end text-white">
      {{ dayOfWeekToString(currentEvent.startDate.getDay()) }} {{ dateToS(currentEvent.startDate) }} à {{ dateToS(currentEvent.endDate, "Hours") }}
    </div>
  </div>

</template>
