<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed} from "vue";
import {useEventsStore} from "@/stores/events_store";
import router from "@/router";
import {dayOfWeekToString, typeToString} from "@/utils/event";
import {VueShowdown as Showdown} from 'vue-showdown';

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("MANAGE_SCORE"))
  router.replace("/")

const eventsStore = useEventsStore()
eventsStore.updateEvents()


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <div class="text-2xl">
      Sélectionnez une activité à modifier :
    </div>

    <!--    <Showdown :options="{-->
    <!--      underline: true,-->
    <!--      emoji: true,-->
    <!--    }"  />-->
    <div class="flex flex-col gap-2 mt-4">
      <v-card v-for="event in eventsStore.events" :key="event.internalId" elevation="4" @click="">
        <div class="p-2">
          <div class="one-line text-xl">
            {{ event.name }}
          </div>
          <div class="flex justify-between">
            <div>
              {{ typeToString(event.type) }}
            </div>
            <div>
              {{ dayOfWeekToString(event.startDate.getDay()) }} {{ event.startDate.getDate() }}
            </div>
          </div>
        </div>
      </v-card>
    </div>
  </div>
</template>
