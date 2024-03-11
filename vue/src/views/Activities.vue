<script lang="ts" setup>

import {useCurrentEventStore} from "@/stores/current_event_store";
import {ref} from "vue";
import {VueShowdown as VShowdown} from "vue-showdown";
import {Activity, ActivityReward} from "@/stores/events_store";

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()

const selectedActivity = ref(null as Activity | null)


</script>

<template>
  <div v-if="currentEventStore.current_event"
       class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <h3 class="mt-2 one-line">
      {{ currentEventStore.current_event!.name }}
    </h3>

    <div v-if="!selectedActivity" class="flex-1 overflow-y-auto -mx-4 px-4 mt-2">
      Liste des activités:
      <v-card v-for="activity in currentEventStore.current_event!.activities" class="mt-2"
              elevation="2" @click="selectedActivity = activity">
        <v-card-title>
          {{ activity.name }}
          <div class="text-sm text-muted flex justify-between">
            <div v-if="((activity.startDate ?? currentEventStore.current_event!.startDate) as any).toLocaleTimeString">
              {{ activity.location || currentEventStore.current_event!.location }} -
              {{ (activity.startDate ?? currentEventStore.current_event!.startDate).toLocaleTimeString().slice(0, -3) }} -
              {{ (activity.endDate ?? currentEventStore.current_event!.endDate).toLocaleTimeString().slice(0, -3) }}
            </div>
            <div class="flex items-center gap-2">
              {{ activity.activityRewards.length }}
              <v-icon>
                mdi-trophy
              </v-icon>
            </div>
          </div>
        </v-card-title>
      </v-card>
    </div>

    <template v-else>
      <h3 class="flex gap-1 items-center justify-between">
        <div>
        <v-icon size="x-small">
          mdi-arrow-right
        </v-icon>
        {{ selectedActivity.name }}
        </div>
        <v-btn variant="text" @click="selectedActivity = null">
          Retour
        </v-btn>
      </h3>

      <div class="flex-1 overflow-y-auto -mx-4 px-4 mt-2">
        <div class="bg-gray-200 rounded p-2 -mx-2">
          <div>
            Description :
          </div>
          <v-showdown :markdown="selectedActivity.description"
                      :options="{underline: true, emoji: true}"/>
        </div>
        <div class="flex flex-col gap-2 mt-2 -mx-2 bg-gray-200 p-2">
          <div>
            Récompenses :
          </div>
          <v-card v-for="reward in (selectedActivity.activityRewards as ActivityReward[])"
                  :key="reward.id" elevation="2">
            <div class="p-2">
              <div class="flex justify-between">
                <div>
                  {{ reward.name }}
                </div>
                <div class="flex items-center">
                  <div class="flex items-center">
                    {{ reward.score }} miels
                  </div>
                  <div class="flex items-center">
                    <template v-if="reward.chest">
                      &nbsp;+&nbsp;
                      <v-icon class="mr-1">
                        mdi-treasure-chest
                      </v-icon>
                      {{ reward.chest }}
                    </template>
                  </div>
                </div>
              </div>
            </div>
          </v-card>
        </div>


      </div>

    </template>


  </div>


</template>
