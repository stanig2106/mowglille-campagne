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
            <div class="flex gap-2">
              <div class="text-muted">
                {{ typeToString(event.type) }}
              </div>
              {{ dayOfWeekToString(event.startDate.getDay?.()) }} {{ event.startDate.getDate?.() }}
            </div>
            <div class="flex items-center">
              <div class="flex items-center border-r border-black pr-1 mr-1">
                0
                <v-icon>mdi-file-document-outline</v-icon>
              </div>
              <v-icon>mdi-comment-alert-outline</v-icon>
            </div>
          </div>
        </div>


        <v-dialog :close-on-back="false" activator="parent" fullscreen no-click-animation persistent>
          <template #default="{isActive}">
            <div class="bg-white h-full p-2 flex flex-col">
              <h3 class="one-line">
                {{ event.name }}
              </h3>
              <h5 class="flex justify-between">
                <span>
                  {{ dayOfWeekToString(event.startDate.getDay()) }} {{ event.startDate.getDate() }},
                  {{ event.startDate.toLocaleTimeString().slice(0, -3) }} - {{ event.endDate.toLocaleTimeString().slice(0, -3) }}
                </span>
                <span class="text-muted">
                  {{ typeToString(event.type) }}
                </span>
              </h5>

              <div class="h-full py-2 my-2">
                <v-expansion-panels multiple>
                  <v-expansion-panel>
                    <template #title>
                      Activités
                    </template>
                    <template #text>
                      
                    </template>
                  </v-expansion-panel>

                  <v-expansion-panel>
                    <template #title>
                      foo
                    </template>
                    <template #text>
                      foo
                    </template>
                  </v-expansion-panel>
                </v-expansion-panels>
              </div>

              <div class="flex justify-end">
                <v-btn variant="text" @click="isActive.value = false">
                  Fermer
                </v-btn>
                <v-btn color="secondary" variant="text" @click="isActive.value = false">
                  Enregistrer
                </v-btn>
              </div>
            </div>

          </template>
        </v-dialog>
      </v-card>
    </div>
  </div>
</template>

<style>
.v-expansion-panel-title {
  @apply py-3 px-4 min-h-0 !important;
}

.v-expansion-panel-text__wrapper {
  @apply py-2 px-4 !important;
}
</style>
