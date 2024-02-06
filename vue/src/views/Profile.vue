<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import DownloadSoutientActif from "@/views/profile/DownloadSoutientActif.vue";
import {provide, ref} from "vue";
import fake_pp from "@/assets/fake/profile.jpeg"
import Galerie from "@/components/Galerie.vue";
import router from "@/router";
import AccountSettings from "@/views/profile/AccountSettings.vue";
import {useOnlineJobsStore} from "@/stores/online_jobs_store";
import axios from "axios";
import {doOnlineJobs} from "@/router/offline";
import {storeToRefs} from "pinia";

const userStore = useUserStore()

userStore.updateUser()

const {onlineJobs} = storeToRefs(useOnlineJobsStore())

function logout() {
  localStorage.removeItem("token")
  router.push("/")
}
</script>


<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col mt-[100px] elevation-2 min-h-[calc(100%-100px)] relative">
    <div class="z-10 rounded-full bg-red-500 w-2/3 aspect-square -mt-[100px] self-center relative">

      <galerie :images="[{
        thumbnailURL: fake_pp,
        largeURL: fake_pp,
        width: 1080,
        height: 1080
      }]" class="w-full h-full rounded-full overflow-hidden"/>

      <v-btn class="absolute bottom-6 -left-2" color="white" icon rounded="lg">
        <v-img :transition="false" class="h-6 w-6" src="@/assets/laurel-wreath.png"/>
        <v-dialog :no-click-animation="true" activator="parent">
          <download-soutient-actif :no-pp="false"/>
        </v-dialog>
      </v-btn>

      <v-btn class="absolute bottom-6 -right-2" color="white" icon rounded="lg">
        <v-icon color="black">mdi-pencil</v-icon>
      </v-btn>
    </div>
    <div class="bg-gray-200 -mt-4 pt-6 p-2 px-8 rounded-md">
      <h2 class="text-3xl text-center one-line">
        {{ userStore.name }}
      </h2>
      <div class="flex justify-between text-xl mt-2">
        <div>
          #{{ userStore.rank == 0 ? "-" : userStore.rank ?? "-" }}
        </div>
        <div class="flex gap-2 items-center">
          {{ userStore.score ?? "-" }}
          <v-img :transition="false" class="h-6 w-6" src="@/assets/honey.png"/>
        </div>
      </div>
    </div>

    <v-btn class="mt-4" size="large" variant="tonal" @click="router.push('stats')">
      <v-icon>mdi-chart-bar</v-icon>
      Statistiques
    </v-btn>

    <v-btn v-if="userStore.staffRoles && userStore.staffRoles.length > 0" class="mt-4"
           color="green" size="large" variant="tonal" @click="router.push('staff')">
      <v-icon>mdi-account-group</v-icon>
      Espace staffeur
    </v-btn>

    <input class="mt-8 h-8 p-2" placeholder="TEST MOI 1" style="border: black 1px solid" type="text">
    <v-text-field class="mt-4" placeholder="TEST MOI 2"/>

    <v-spacer/>

    <v-btn v-if="onlineJobs.length != 0" class="mt-4" color="red" size="large" variant="tonal">
      <v-icon>mdi-clock</v-icon>
      Requête en attente ({{ onlineJobs.length }})
      <v-dialog activator="parent">
        <template #default="{isActive}">
          <v-card loading>
            <v-card-title>
              <div class="flex justify-between items-center w-full gap-2">
                Requêtes en attente
                <v-btn density="comfortable" icon rounded="lg" @click="doOnlineJobs">
                  <v-icon>mdi-refresh</v-icon>
                </v-btn>
              </div>
            </v-card-title>
            <div class="mt-2 p-4 border-b border-b-black">
              Connectez vous à internet pour effectuer les requêtes en attente
            </div>
            <div class="p-4 overflow-y-auto">
              <div v-for="job in onlineJobs" :key="JSON.stringify(job)" class="mb-2">
                <div>
                  {{ job.description.title }}
                </div>
                <span class="text-sm text-muted">
                {{ job.description.message }}
              </span>
              </div>
            </div>
            <v-card-actions>
              <v-spacer/>
              <v-btn variant="text" @click="isActive.value = false">
                Fermer
              </v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-btn>


    <v-btn class="mt-4" size="large" variant="tonal">
      <v-icon>mdi-cog</v-icon>
      Paramètres du compte

      <account-settings/>
    </v-btn>

    <v-btn class="mt-4" color="red" size="large" variant="tonal">
      <v-dialog activator="parent">
        <template #default="{isActive}">
          <v-card>
            <v-card-title>
              <div class="flex justify-between items-center w-full gap-2">
                Déconnexion
              </div>
            </v-card-title>
            <div class="mt-2 p-4">
              Êtes-vous sûr de vouloir vous déconnecter ?
            </div>
            <v-card-actions>
              <v-spacer/>
              <v-btn variant="text" @click="isActive.value = false">
                Annuler
              </v-btn>
              <v-btn color="red" @click="logout">
                Déconnexion
              </v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>

      <v-icon>mdi-logout</v-icon>
      Déconnexion
    </v-btn>

  </div>

</template>

