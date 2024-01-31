<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, onMounted, ref} from "vue";
import {useStaffeursStore} from "@/stores/staffeurs_store";
import {storeToRefs} from "pinia";
import VConfirmBtn from "@/components/VConfirmBtn.vue";
import axios from "axios";
import {roles} from "@/views/staff/staff";
import FindUser from "@/components/FindUser.vue";

const currentUser = useUserStore()
currentUser.updateUser()

const {staffers} = storeToRefs(useStaffeursStore())
const {updateStaffeurs} = useStaffeursStore()

updateStaffeurs()

const edit_roles = ref<typeof roles[number][]>([])

function delete_staffer(publicToken: string) {
  edit_roles.value = []
  update_staffer(publicToken)
}

async function update_staffer(publicToken: string) {
  return axios.put("/staffers/" + publicToken, {
    roles: edit_roles.value
  }).then(() => updateStaffeurs())
}

const saving = ref(false)
</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <v-btn class="mb-4">
      Ajouter un staffeur
      <v-dialog activator="parent" height="80%">
        <find-user model-value="" class="h-full"/>
      </v-dialog>
    </v-btn>

    <div v-for="staffer in staffers" :key="staffer.publicToken"
         class="flex flex-row items-center justify-start gap-2">
      <div>
        <div class="text-xl">
          {{ staffer.name }}
        </div>
        <div class="text-sm text-muted one-line">
          {{ (staffer as any).roles.join(", ") }}
        </div>
      </div>
      <v-btn class="!ml-auto" icon rounded="lg" @click="edit_roles = staffer.roles">
        <v-icon>mdi-pencil</v-icon>
        <v-dialog activator="parent" persistent>
          <template #default="{isActive}">

            <v-card class="overflow-y-hidden">
              <v-card-title>
                Modifier {{ staffer.name }}
              </v-card-title>
              <v-card-text class="overflow-y-auto">
                <v-form>
                  <v-checkbox v-for="role in roles" :key="role" :disabled="role == 'NEW_STAFF'"
                              :label="role"
                              :model-value="edit_roles.includes(role)" density="compact"
                              hide-details
                              @change="edit_roles = edit_roles.includes(role) ? edit_roles.filter(r => r != role) : [...edit_roles, role]"/>
                </v-form>
              </v-card-text>
              <v-card-actions class="flex justify-end">
                <v-btn :disabled=" edit_roles.length == roles.length - (edit_roles.includes('NEW_STAFF') ? 0 : 1)"
                       color="black" @click="edit_roles = roles.filter(r => edit_roles.includes('NEW_STAFF') || r != 'NEW_STAFF')">
                  Sél. tout
                </v-btn>
                <v-spacer/>
                <v-btn :loading="saving" color="secondary"
                       @click="saving = true; update_staffer(staffer.publicToken)
                             .then(() => isActive.value = saving = false).catch(() => saving = false)">
                  Enregistrer
                </v-btn>
                <v-btn :disabled="saving" @click="isActive.value = false">
                  Annuler
                </v-btn>
              </v-card-actions>
            </v-card>
          </template>
        </v-dialog>
      </v-btn>
      <v-confirm-btn :disabled="staffer.roles.includes('NEW_STAFF')" icon rounded="lg"
                     @click="delete_staffer(staffer.publicToken)">
        <v-icon>mdi-trash-can-outline</v-icon>
      </v-confirm-btn>

    </div>

  </div>
</template>
