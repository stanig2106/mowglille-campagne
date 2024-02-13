<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, ref, watch} from "vue";
import {Activity, ActivityReward, useEventsStore} from "@/stores/events_store";
import router from "@/router";
import {Event} from "@/stores/events_store";
import {useDate} from "vuetify";
import {computedWithControl} from "@vueuse/core";
import {VueShowdown as VShowdown} from "vue-showdown";
import FindUser from "@/components/FindUser.vue";
import {User} from "@/stores/users_store";
import {doItOnline, useOnline} from "@/router/offline";
import axios from "axios";


const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("SCORE"))
  router.replace("/")

const eventsStore = useEventsStore()
eventsStore.updateEvents()

const _event = ref(null as Event | null)
const event = computed(() => {
  if (_event.value)
    return _event.value
  let current: Event | undefined = undefined
  for (const e of eventsStore.events) {
    if (new Date() > e.startDate && new Date() < e.endDate)
      return e
    else if (new Date() < e.startDate) {
      if (current == undefined)
        current = e
      else if (e.startDate < current.startDate)
        current = e
    }
  }
  return current
})

const current = computed(() => event.value &&
  new Date() > event.value.startDate && new Date() < event.value.endDate)

const timeToNext = computedWithControl(() => void 0, () => {
  if (event.value == undefined)
    return "0 s"
  const res = event.value.startDate.getTime() - new Date().getTime()
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

const selectedActivity = ref(null as Activity | null)
const selectedReward = ref(null as ActivityReward | null)

const selectedUser = ref(null as User | null)

const {online} = useOnline()

watch(selectedUser, async () => {
  if (selectedUser.value == null)
    return

  await axios.post("/staff/reward", {
    user: selectedUser.value.publicToken,
    activity_reward_id: selectedReward.value!.id,
    only_check: true
  }).then(({data}) => {
    if (data.error) {
      error.value = true
      error_reason.value = data.error
    }
  })

  if (error.value)
    return

  doItOnline({
    url: "/staff/reward",
    method: "post",
    data: {
      user: selectedUser.value.publicToken,
      activity_reward_id: selectedReward.value!.id,
    }
  }, {
    title: "Offrir une récompenses",
    message: `Vous avez récompensé ${selectedUser.value.firstName} avec ${selectedReward.value!.name} `
      + `à l'activité ${selectedActivity.value!.name}`
  })

  done.value = true
  if (!online.value)
    offline_cached.value = true
})

const done = ref(false)
const error_reason = ref(null as string | null)
const error = ref(false)
const offline_cached = ref(false)

function reset() {
  selectedUser.value = null
  selectedReward.value = null
  done.value = false
  offline_cached.value = false
  error.value = false
}

watch(done, () => {
  if (!done.value)
    reset()
})
watch(error, () => {
  if (!error.value)
    reset()
})


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <template v-if="event">

      <div class="flex justify-between text-md">
        <div class="flex gap-2 items-center">
          <span>
            {{ current ? "En cours" : "Prochainement :" }}
          </span>
          <span v-if="!current">
            {{ timeToNext }}
          </span>
        </div>
        <v-btn v-if="!selectedActivity" density="comfortable" icon rounded="lg">
          <v-icon>mdi-calendar-refresh-outline</v-icon>
          <v-dialog activator="parent">
            <template #default="{isActive}">
              <v-card>
                <v-card-title>
                  Sélectionnez un événement
                </v-card-title>
                <v-list class="-mt-2">
                  <v-list-item v-for="e in eventsStore.events" :key="e.internalId"
                               @click="_event = e; isActive.value = false">
                    <v-list-item-title>
                      {{ e.name }}
                    </v-list-item-title>
                    <v-list-item-subtitle>
                      {{ e.startDate.toLocaleDateString().slice(0, -5) }},
                      {{ e.startDate.toLocaleTimeString().slice(0, -3) }} -
                      {{ e.endDate.toLocaleTimeString().slice(0, -3) }}
                    </v-list-item-subtitle>
                  </v-list-item>
                </v-list>
                <div class="flex justify-end pb-2 pr-2">
                  <v-btn color="secondary" variant="text" @click="isActive.value = false">
                    Retour
                  </v-btn>
                </div>
              </v-card>
            </template>

          </v-dialog>
        </v-btn>
        <v-btn v-else color="secondary" @click="selectedActivity = null">
          Retour
        </v-btn>
      </div>

      <h3 class="mt-2 one-line">
        {{ event?.name }}
      </h3>

      <div v-if="!selectedActivity" class="flex-1 overflow-y-auto -mx-4 px-4 mt-2">
        Liste des activités:
        <v-card v-for="activity in event.activities" class="mt-2"
                elevation="2" @click="selectedActivity = activity">
          <v-card-title>
            {{ activity.name }}
            <div class="text-sm text-muted flex justify-between">
              <div>
                {{ activity.location || event.location }} -
                {{ (activity.startDate ?? event.startDate).toLocaleTimeString().slice(0, -3) }} -
                {{ (activity.endDate ?? event.endDate).toLocaleTimeString().slice(0, -3) }}
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
        <h3 class="flex gap-1 items-center">
          <v-icon size="x-small">
            mdi-arrow-right
          </v-icon>
          {{ selectedActivity.name }}
        </h3>

        <div class="flex-1 overflow-y-auto -mx-4 px-4 mt-2">
          <div class="bg-gray-200 rounded p-2 -mx-2">
            <div>
              Description :
            </div>
            <v-showdown :markdown="selectedActivity.description"
                        :options="{underline: true, emoji: true}"/>
          </div>
          <div class="bg-gray-200 rounded p-2 -mx-2 mt-2">
            <div>
              Description interne :
            </div>
            {{ selectedActivity.internalDescription }}
          </div>

          <div class="flex flex-col gap-2 mt-2 -mx-2 bg-gray-200 p-2">
            <div>
              Récompenses :
            </div>
            <v-card v-for="reward in (selectedActivity.activityRewards as ActivityReward[])"
                    :key="reward.id" elevation="2" @click="selectedReward = reward">
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
                <div>
                  {{ reward.internalDescription }}
                </div>
              </div>

              <v-dialog :model-value="selectedReward != null" persistent>
                <template #default="{isActive}">
                  <v-card>
                    <div class="p-2">
                      <h4>
                        Offrir une récompense
                      </h4>
                      <h5 class="text-muted one-line">
                        {{ reward.name }}
                      </h5>

                      <div class="-mx-2">
                        <find-user :key="selectedUser?.publicToken" v-model="selectedUser"
                                   class="w-full h-full"
                                   hide-cancel
                                   variant="text"/>
                      </div>
                      <div class="flex justify-end">
                        <v-btn color="secondary" variant="text"
                               @click="selectedReward = null;
                               isActive.value = false">
                          Annuler
                        </v-btn>
                      </div>
                    </div>
                  </v-card>
                </template>


              </v-dialog>
            </v-card>
          </div>


        </div>

      </template>

    </template>
  </div>

  <v-dialog v-model="done">
    <v-card :title="offline_cached ? 'Vous êtes hors-ligne' : 'Succès'">
      <v-card-text class="flex flex-col gap-4 items-center text-center !text-xl !pt-6">
        <template v-if="offline_cached">
          <v-icon color="secondary" size="x-large">mdi-table-arrow-up</v-icon>
          Votre demande à bien été pris en compte, dés que vous serez connecter à internet,
          {{ selectedUser!.firstName }} recevras la récompense {{ selectedReward!.name }} à condition
          qu'il n'ai pas déjà reçu cette récompense.
        </template>

        <template v-else>
          <v-icon color="green" size="x-large">mdi-check-circle</v-icon>
          La récompense {{ selectedReward?.name }} a bien été offerte à {{ selectedUser?.firstName }}
        </template>
      </v-card-text>
      <v-card-actions>
        <v-spacer/>
        <v-btn @click="done = false">
          Ok
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

  <v-dialog v-model="error">
    <v-card title="Une erreur est survenue">
      <v-card-text class="flex flex-col gap-4 items-center text-center !text-xl !pt-6">
        <v-icon color="red" size="x-large">mdi-alert-circle</v-icon>
        {{ error_reason ?? "Veuillez réessayer" }}
      </v-card-text>
      <v-card-actions>
        <v-spacer/>
        <v-btn color="secondary" @click="() => {error = false; selectedUser = null}">
          Réessayer
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
