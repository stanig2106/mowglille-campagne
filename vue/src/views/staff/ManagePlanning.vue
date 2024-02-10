<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, ref, watch} from "vue";
import axios from "axios";
import {useOffline} from "@/router/offline";
import router from "@/router";
import {useManagePlanningStore} from "@/stores/manage_planning_store";
import FindUser from "@/components/FindUser.vue";
import VConfirmBtn from "@/components/VConfirmBtn.vue";
import {User} from "@/stores/users_store";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("MANAGE_PLANNING"))
  router.replace("/")

const planningLink = ref("")

const planning_link_invalid = computed(() => {
  try {
    const url = new URL(planningLink.value)
    return url.hostname != "docs.google.com" || !url.pathname.startsWith("/spreadsheets/d");
  } catch (e) {
    return true
  }
})

const {offline} = useOffline()

const updatePlanningLink = async () => {
  await axios.post("/update_planning_link", {link: planningLink.value})
  await planningStore.updateManagePlanning()
}

const planningStore = useManagePlanningStore()
planningStore.updateManagePlanning()

const open_sheet = () => window.open(planningStore.sheet_link!, '_blank')

const column = ref("")
const user = ref(null as User | null)

watch(() => user.value, async () => {
  if (user.value && column.value) {
    await axios.post("/planning_association",
      {letter: column.value, public_token: user.value.publicToken})
    await planningStore.updateManagePlanning()
    column.value = ""
    user.value = null
  }
})

const delete_association = (letter: string) => {
  axios.delete("/planning_association", {data: {letter}})
    .then(() => planningStore.updateManagePlanning())
}
</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <v-btn :disabled="offline">
      <v-icon>mdi-pencil</v-icon>
      <span>Modifier le lien du sheet planning</span>

      <v-dialog activator="parent">
        <template #default="{isActive}">
          <v-card>
            <v-card-title>Modifier le lien du sheet planning</v-card-title>
            <v-card-text>
              <v-text-field v-model="planningLink"
                            :error-messages="planningLink.length != 0 && planning_link_invalid ?
                                              'Le lien est invalide' : ''"
                            label="Lien du sheet planning"
              />
            </v-card-text>
            <v-card-actions>
              <v-spacer/>
              <v-btn @click="isActive.value = false">Annuler</v-btn>
              <v-btn :disabled="planning_link_invalid" color="secondary" @click="() => updatePlanningLink()
                      .then(() => isActive.value = false)">
                Enregistrer
              </v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-btn>
    <v-btn :disabled="offline" class="mt-4" @click="open_sheet">
      <v-icon>mdi-google-spreadsheet</v-icon>
      <span>Ouvrir le sheet planning</span>
    </v-btn>

    <v-btn :disabled="offline" class="mt-4">
      <v-icon>mdi-account-switch</v-icon>
      <span>Définir les associations</span>

      <v-dialog activator="parent">
        <template #default="{isActive}">
          <v-card>
            <v-card-title>Définir les associations</v-card-title>
            <v-card-text>
              <v-text-field v-model="column" :error-messages="planningStore.associations.find(a => a.letter == column) ?
                                                             'Cette colonne est déjà associée' : ''"
                            label="Colonne sur le sheet"/>

              <find-user v-model="user" :disabled="column.length == 0 || !!planningStore.associations.find(a => a.letter == column)" class="-m-4" hide-cancel
                         must-be-online
                         variant="text" @update:modelValue="isActive.value = false"/>
            </v-card-text>
            <v-card-actions>
              <v-spacer/>
              <v-btn @click="isActive.value = false">Annuler</v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-btn>

    <h3 class="mt-4">
      Associations actuelles :
    </h3>

    <div class="mt-4 flex gap-2 h-full flex-col">
      <div v-for="association in planningStore.associations" :key="association.letter"
              class="flex items-center justify-between w-full border-b pb-2">
        Colonne {{ association.letter }} - {{ association.name }}

        <v-confirm-btn density="compact" icon rounded="lg"
                       @click="() => delete_association(association.letter)">
          <v-icon>mdi-delete</v-icon>
        </v-confirm-btn>
      </div>

    </div>


  </div>
</template>
