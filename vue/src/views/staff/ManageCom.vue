<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {ref, watch} from "vue";
import {Event, useEventsStore} from "@/stores/events_store";
import router from "@/router";
import {dayOfWeekToString, typeToString} from "@/utils/event";
import {VueShowdown as VShowdown} from 'vue-showdown';
import VConfirmBtn from "@/components/VConfirmBtn.vue";
import axios from "axios";
import activity from "@/views/staff/Activity.vue";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("MANAGE_COM"))
  router.replace("/")

const eventsStore = useEventsStore()
eventsStore.updateEvents()

const hasError = ref(false)
const errorReason = ref("")

const image = ref([] as File[])

async function save(event: Event): Promise<boolean> {
  const formData = new FormData()
  formData.append("description", event.description)
  if (image.value.length > 0)
    formData.append("file", image.value[0])

  return axios.post("/staff/add_com/" + event.internalId, formData, {
    headers: {
      "Content-Type": "multipart/form-data"
    },
    timeout: 120 * 1000 // 2 minutes
  }).then(({data}) => {
    if (data.ok) {
      eventsStore.updateEvents()
      return true
    }

    hasError.value = true
    errorReason.value = data.error
    return false
  }).catch(e => {
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
                <v-textarea v-model="event.description"
                            density="comfortable" hide-details
                            label="Description public" outlined rows="15"/>
                <div class="relative -mt-3">
                  <v-btn class="absolute right-1 -translate-y-full">
                    Aperçu
                    <v-dialog activator="parent" close-on-content-click>
                      <v-card>
                        <div class="flex flex-col gap-2 p-4 overflow-y-auto">
                          <h5>
                            Aperçu de la description :
                          </h5>
                          <v-showdown :markdown="event.description" :options="{underline: true, emoji: true}"/>
                        </div>
                      </v-card>
                    </v-dialog>
                  </v-btn>
                </div>

                <v-file-input v-model="image"
                              class="mt-8" dense hide-details
                              label="Image" outlined/>

                <v-img :src="event.com" class="mt-4"/>
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
