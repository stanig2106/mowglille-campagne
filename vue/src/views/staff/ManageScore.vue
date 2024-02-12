<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {reactive, ref} from "vue";
import {Event, Activity, useEventsStore} from "@/stores/events_store";
import router from "@/router";
import {dayOfWeekToString, typeToString} from "@/utils/event";
import {VueShowdown as Showdown} from 'vue-showdown';
import {Rarity} from "@/views/collection/Chest.vue";
import VConfirmBtn from "@/components/VConfirmBtn.vue";
import axios from "axios";


const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("MANAGE_SCORE"))
  router.replace("/")

const eventsStore = useEventsStore()
eventsStore.updateEvents()

const newActivityId = ref("")

function newActivity(id: string): Activity & { new: true } {
  return {
    internalId: id,
    name: "Activité sans nom",
    description: "",
    activityRewards: [],
    startDate: null,
    endDate: null,
    internalDescription: "",
    location: "",
    new: true
  }
}


function delete_activity(event: Event, activity: Activity & { new?: true }) {
  event.activities = event.activities.filter(a => a != activity)

  if (activity.new) return
}

// 15 minutes interval
function timeFromTo(start: Date, end: Date, nullLabel = "Aucun") {
  const times = []
  for (let i = start.getTime(); i <= end.getTime(); i += 15 * 60 * 1000)
    times.push({
      title: new Date(i).toLocaleTimeString().slice(0, -3),
      value: new Date(i)
    })
  return [
    {title: nullLabel, value: null},
    ...times
  ]
}

const openedActivities = ref([] as (Activity & { new?: true })[])

const addingActivityRewards = reactive({
  name: "",
  internalDescription: "",
  chest: null as Rarity | null,
  score: 0
})

function resetAddingActivityRewards() {
  addingActivityRewards.name = ""
  addingActivityRewards.internalDescription = ""
  addingActivityRewards.chest = null
  addingActivityRewards.score = 0
}


const hasError = ref(false)
const errorReason = ref("")

async function save(event: Event): Promise<boolean> {
  hasError.value = false
  return axios.put('/events/' + event.internalId, event)
    .then(() => {
      hasError.value = false
      return true
    })
    .catch((e) => {
      hasError.value = true
      errorReason.value = e
      return false
    })
}


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <div class="text-2xl">
      Sélectionnez une activité à modifier :
    </div>

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
              {{ dayOfWeekToString(event.startDate?.getDay?.()) }} {{ event.startDate?.getDate?.() }}
            </div>
            <div class="flex items-center">
              <div class="flex items-center border-r border-black pr-1 mr-1">
                {{ event.activities?.length }}
                <v-icon>mdi-file-document-outline</v-icon>
              </div>
              <v-icon>mdi-comment-alert-outline</v-icon>
            </div>
          </div>
        </div>


        <v-dialog :close-on-back="false" activator="parent" fullscreen no-click-animation
                  persistent @update:modelValue="eventsStore.updateEvents">
          <template #default="{isActive}">
            <div class="bg-white h-full p-2 flex flex-col overflow-y-auto overflow-x-hidden">
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
                <v-expansion-panels v-model="openedActivities" variant="accordion">
                  <v-expansion-panel v-for="activity in event.activities" :key="activity.internalId"
                                     :value="activity">
                    <v-expansion-panel-title>
                      <div class="one-line">
                        {{ activity.internalId }} - {{ activity.name }}
                      </div>
                    </v-expansion-panel-title>
                    <v-expansion-panel-text>
                      <div class="flex flex-col gap-2">
                        <v-text-field v-model="activity.name"
                                      density="comfortable" hide-details
                                      label="Nom" outlined/>

                        <v-textarea v-model="activity.description"
                                    density="comfortable" hide-details
                                    label="Description public" outlined rows="4"/>
                        <div class="relative -mt-3">
                          <v-btn class="absolute right-1 -translate-y-full">
                            Aperçu
                            <v-dialog activator="parent" close-on-content-click>
                              <v-card>
                                <div class="flex flex-col gap-2 p-4 overflow-y-auto">
                                  <h5>
                                    Aperçu de la description :
                                  </h5>
                                  <showdown :markdown="activity.description" :options="{underline: true, emoji: true}"/>
                                </div>
                              </v-card>
                            </v-dialog>
                          </v-btn>
                        </div>

                        <v-textarea v-model="activity.internalDescription"
                                    density="comfortable" hide-details
                                    label="Description interne" outlined rows="4"/>

                        <v-text-field v-model="activity.location"
                                      :label="'Lieu (si different de ' + event.location + ')'" density="comfortable"
                                      hide-details outlined/>

                        <div class="flex gap-2 >:w-full">
                          <v-select v-model="activity.startDate"
                                    :items="timeFromTo(event.startDate, event.endDate, 'Début de l\'évent')"
                                    dense hide-details label="Début" outlined/>
                          <v-select v-model="activity.endDate"
                                    :items="timeFromTo(event.startDate, event.endDate, 'Fin de l\'évent')"
                                    dense hide-details label="Fin" outlined/>
                        </div>

                        <v-btn class="mb-1">
                          {{ activity.activityRewards.length }} récompenses

                          <v-dialog activator="parent">
                            <v-card>
                              <div class="flex flex-col gap-2 p-4">
                                <h3>
                                  Récompenses de {{ activity.internalId }}
                                </h3>

                                <v-card v-for="ar in activity.activityRewards" :key="ar.id">
                                  <div class="p-2">
                                    <div class="flex justify-between">
                                      <div>
                                        {{ ar.name }}
                                      </div>
                                      <div class="flex items-center">
                                        <div class="flex items-center">
                                          {{ ar.score }} miels
                                        </div>
                                        <div class="flex items-center">
                                          <template v-if="ar.chest">
                                            &nbsp;+&nbsp;
                                            <v-icon>
                                              mdi-treasure-chest
                                            </v-icon>
                                            {{ ar.chest }}
                                          </template>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="text-muted one-line">
                                      {{ ar.internalDescription }}
                                    </div>
                                  </div>

                                  <v-dialog activator="parent">
                                    <template #default="{isActive}">
                                      <v-card>
                                        <div class="flex flex-col gap-2 p-4">
                                          <h3>
                                            Modifier la récompense
                                          </h3>

                                          <v-text-field v-model="ar.name" hide-details label="Nom" outlined/>
                                          <v-text-field v-model="ar.internalDescription" hide-details label="Description interne" outlined/>

                                          <v-select v-model="ar.chest"
                                                    :items="[{ title: 'Aucun', value: null }, { title: 'Rare', value: 'rare' }, { title: 'Épic', value: 'epic' }, { title: 'Légendaire', value: 'legendary'}]"
                                                    hide-details label="Coffre" outlined/>

                                          <v-text-field v-model.number="ar.score"
                                                        hide-details label="Score" outlined suffix="miel"/>

                                          <div class="flex justify-end mt-2">
                                            <v-btn color="secondary" variant="text"
                                                   @click="isActive.value = false">
                                              Enregistrer
                                            </v-btn>
                                          </div>
                                        </div>
                                      </v-card>
                                    </template>
                                  </v-dialog>
                                </v-card>

                                <v-btn class="mt-2">
                                  Ajouter une récompense
                                  <v-dialog activator="parent" @update:model-value="resetAddingActivityRewards">
                                    <template #default="{isActive}">
                                      <v-card>
                                        <div class="flex flex-col gap-2 p-4">
                                          <h3>
                                            Ajouter une récompense
                                          </h3>

                                          <v-text-field v-model="addingActivityRewards.name" hide-details label="Nom" outlined/>
                                          <v-text-field v-model="addingActivityRewards.internalDescription" hide-details label="Description interne" outlined/>

                                          <v-select v-model="addingActivityRewards.chest"
                                                    :items="[{ title: 'Aucun', value: null }, { title: 'Rare', value: 'rare' }, { title: 'Épic', value: 'epic' }, { title: 'Légendaire', value: 'legendary'}]"
                                                    hide-details label="Coffre" outlined/>

                                          <v-text-field v-model.number="addingActivityRewards.score"
                                                        hide-details label="Score" outlined suffix="miel"/>

                                          <div class="flex justify-end mt-2">
                                            <v-btn color="secondary" variant="text"
                                                   @click="activity.activityRewards.push({id: 0, ...addingActivityRewards}); isActive.value = false">
                                              Ajouter
                                            </v-btn>
                                          </div>
                                        </div>
                                      </v-card>
                                    </template>
                                  </v-dialog>
                                </v-btn>

                              </div>
                            </v-card>

                          </v-dialog>
                        </v-btn>

                        <v-btn color="red">
                          Supprimer l'activité

                          <v-dialog activator="parent">
                            <template #default="{isActive}">
                              <v-card>
                                <div class="flex flex-col gap-2 px-4 py-2">
                                  <h3 class="one-line">
                                    Supprimer l'activité
                                  </h3>

                                  <div>
                                    Êtes-vous sûr de vouloir supprimer l'activité {{ activity.internalId }} ?
                                  </div>

                                  <div class="flex justify-end gap-2">
                                    <v-btn variant="text" @click="isActive.value = false">
                                      Annuler
                                    </v-btn>
                                    <v-btn color="secondary" variant="text" @click="delete_activity(event, activity); isActive.value = false">
                                      Supprimer
                                    </v-btn>
                                  </div>
                                </div>

                              </v-card>
                            </template>
                          </v-dialog>
                        </v-btn>
                      </div>
                    </v-expansion-panel-text>
                  </v-expansion-panel>
                </v-expansion-panels>

                <h4 v-if="event.activities.length == 0" class="text-center">
                  Aucune activité
                </h4>

                <div class="flex justify-end gap-2 mt-4">
                  <v-btn>
                    Ajouter une activité
                    <v-dialog activator="parent">
                      <template #default="{isActive}">
                        <v-card>
                          <div class="flex flex-col gap-2 p-4">
                            <h3>
                              Ajouter une activité
                            </h3>
                            <v-text-field v-model="newActivityId" autofocus hide-details label="ID de l'activité" outlined/>
                            <div class="flex justify-end">
                              <v-btn color="secondary" variant="text"
                                     @click="openedActivities = [newActivity(newActivityId)];
                                           event.activities.push(openedActivities[0]); isActive.value = false;
                                           newActivityId = ''">
                                Ajouter
                              </v-btn>
                            </div>
                          </div>
                        </v-card>
                      </template>
                    </v-dialog>
                  </v-btn>
                </div>
              </div>

              <div class="flex justify-end">
                <v-confirm-btn location="top" variant="text"
                               @click="isActive.value = false">
                  Annuler
                </v-confirm-btn>
                <v-btn color="secondary" variant="text"
                       @click="save(event).then(v => isActive.value = !v)">
                  Enregistrer
                </v-btn>

                <v-dialog v-model="hasError">
                  <v-card>
                    <div class="flex flex-col gap-2 p-4">
                      <h3>
                        Erreur
                      </h3>
                      <div>
                        Une erreur est survenue lors de l'enregistrement :
                        {{ errorReason }}
                      </div>
                      <div class="flex justify-end">
                        <v-btn color="secondary" variant="text"
                               @click="hasError = false">
                          Fermer
                        </v-btn>
                      </div>
                    </div>
                  </v-card>
                </v-dialog>
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
  @apply py-2 px-2 !important;
}
</style>
