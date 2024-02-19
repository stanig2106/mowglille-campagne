<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import DownloadSoutientActif from "@/views/profile/DownloadSoutientActif.vue";
import {computed, ref} from "vue";
import Galerie from "@/components/Galerie.vue";
import router from "@/router";
import AccountSettings from "@/views/profile/AccountSettings.vue";
import {useOnlineJobsStore} from "@/stores/online_jobs_store";
import axios from "axios";
import {doOnlineJobs} from "@/router/offline";
import {storeToRefs} from "pinia";

const userStore = useUserStore()

userStore.updateUser()

const onlineJobs = computed(() =>
  useOnlineJobsStore().onlineJobs.filter(j => j.description != null)
)


function logout() {
  localStorage.removeItem("token")
  router.push("/")
}

const ppInput = ref<HTMLInputElement | null>(null)

async function uploadPP() {
  const file = ppInput.value!.files?.[0]
  if (!file)
    return
  const formData = new FormData()
  formData.append("file", file)
  await axios.post("/update_profile_picture", formData, {
    headers: {
      "Content-Type": "multipart/form-data"
    },
    timeout: 120 * 1000 // 120 seconds
  }).then(() => {
    userStore.updateUser()
  }).catch()
  ppInput.value!.form!.reset()
}
</script>


<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col mt-[100px] elevation-2 min-h-[calc(100%-100px)] relative square-shadow">
    <div class="z-10 rounded-full bg-gray-200 w-2/3 aspect-square -mt-[100px] self-center relative">

      <galerie v-if="userStore.pp" :images="[{
        thumbnailURL: userStore.pp,
        largeURL: userStore.pp,
        width: 1080,
        height: 1080
      }]" class="w-full h-full rounded-full overflow-hidden absolute top-0 left-0"/>

      <v-btn class="absolute bottom-6 -left-2" color="white" icon rounded="lg">
        <v-img :transition="false" class="h-6 w-6" src="@/assets/laurel-wreath.png"/>
        <v-dialog :no-click-animation="true" activator="parent">
          <download-soutient-actif :pp="userStore.pp ?? null"/>
        </v-dialog>
      </v-btn>

      <v-btn class="absolute bottom-6 -right-2 overflow-hidden" color="white" for="ppInput" icon
             rounded="lg" tag="label">
        <v-icon color="black">mdi-pencil</v-icon>
        <form class="absolute -top-[100vh]">
          <input id="ppInput" ref="ppInput" accept="image/*" class="absolute -top-full -left-full" type="file" @change="uploadPP"/>
        </form>
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

    <!--    <v-btn class="mt-4" size="large" variant="tonal" @click="router.push('stats')">-->
    <!--      <v-icon>mdi-chart-bar</v-icon>-->
    <!--      Statistiques-->
    <!--    </v-btn>-->

    <!--    <v-btn v-if="userStore.staffRoles && userStore.staffRoles.length > 0" class="mt-4"-->
    <!--           color="green" size="large" variant="tonal" @click="router.push('staff')">-->
    <!--      <v-icon>mdi-account-group</v-icon>-->
    <!--      Espace staffeur-->
    <!--    </v-btn>-->

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
                  {{ job.description!.title }}
                </div>
                <span class="text-sm text-muted">
                  {{ job.description!.message }}
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

