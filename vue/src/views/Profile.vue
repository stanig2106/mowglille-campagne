<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import DownloadSoutientActif from "@/views/profile/DownloadSoutientActif.vue";
import {computed, ref, watch} from "vue";
import Galerie from "@/components/Galerie.vue";
import router from "@/router";
import AccountSettings from "@/views/profile/AccountSettings.vue";
import {useOnlineJobsStore} from "@/stores/online_jobs_store";
import axios from "axios";
import {doOnlineJobs} from "@/router/offline";
import {storeToRefs} from "pinia";
import placeholder_pp from "@/assets/placeholder_pp";
//@ts-ignore
import {VueAvatar} from 'vue-avatar-editor-improved'

import {useElementSize} from '@vueuse/core'
import {ProfileImage} from "@/utils/profile_pictures";


const userStore = useUserStore()

userStore.updateUser()

const onlineJobs = computed(() =>
  useOnlineJobsStore().onlineJobs.filter(j => j.description != null)
)


function logout() {
  localStorage.removeItem("token")
  router.push("/")
}

const ppScale = ref(1)
const avatar = ref<VueAvatar | null>(null)
const avatarContainer = ref<HTMLDivElement | null>(null)
const {width: avatarContainerSize} = useElementSize(avatarContainer)

const imageLoaded = ref(false)
const avatarLoading = ref(false)
const originalImage = ref(null as File | null)

const error_upload = ref(false)

watch(error_upload, (value, oldValue) => {
  if (!value && oldValue)
    avatarLoading.value = false
})

async function uploadPP() {
  const blob = await new Promise<Blob | null>((resolve) => {
    avatar.value!.getImageScaled().toBlob((blob: Blob | null) => {
      resolve(blob)
    })
  })
  if (!blob)
    return

  avatarLoading.value = true

  await new Promise(resolve => setTimeout(resolve, 5000))
  const formData = new FormData()
  formData.append("file", blob)
  formData.append("original", originalImage.value!)
  await axios.post("/update_profile_picture", formData, {
    headers: {
      "Content-Type": "multipart/form-data"
    },
    timeout: 120 * 1000 // 120 seconds
  }).then(userStore.updateUser).catch(() => {
    error_upload.value = true
  })

  avatarLoading.value = false
}

function deletePP() {
  return axios.delete(
    "/update_profile_picture",
  ).then(userStore.updateUser).catch()
}

function onImageLoad() {
  imageLoaded.value = true
  const imageInput = (avatar.value!.canvas as HTMLCanvasElement).nextElementSibling as HTMLInputElement
  originalImage.value = imageInput.files![0]
}

watch(avatar, (new_avatar) => {
  if (!new_avatar) return
  (avatar.value!.canvas as HTMLCanvasElement).nextElementSibling!.id = "pp-input"
})

const pictureDialog = ref(false)
</script>


<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col mt-[100px] elevation-2 min-h-[calc(100%-100px)] relative square-shadow">
    <div class="z-10 rounded-full bg-gray-200 w-2/3 aspect-square -mt-[100px] self-center relative">

      <galerie v-if="userStore.pp" :images="[userStore.pp]"
               class="w-full h-full rounded-full overflow-hidden absolute top-0 left-0"/>

      <v-img v-else :src="ProfileImage.new(userStore.name, {fontSize: 20}).png()"
             class="w-full h-full rounded-full bg-gray-200"/>

      <v-btn class="absolute bottom-6 -left-2" color="white" icon rounded="lg">
        <v-img :transition="false" class="h-6 w-6" src="@/assets/laurel-wreath.webp"/>
        <v-dialog :no-click-animation="true" activator="parent">
          <template #default="{isActive}">
            <download-soutient-actif :pp="userStore.orr_pp ?? null"
                                     :pp_bg="userStore.bg_pp ?? null"
                                     @add_photo="isActive.value = false; pictureDialog = true"
                                     @cancel="isActive.value = false"
                                     @download="isActive.value = false"
            />
          </template>
        </v-dialog>
      </v-btn>

      <v-btn class="absolute bottom-6 -right-2 overflow-hidden" color="white" icon
             rounded="lg" @click="imageLoaded = false">
        <v-icon color="black">mdi-pencil</v-icon>
        <v-dialog v-model="pictureDialog" activator="parent" persistent>
          <template #default="{isActive}">
            <v-card :disabled="avatarLoading" :loading="avatarLoading">
              <v-card-title>
                Changer de photo de profil
              </v-card-title>
              <div ref="avatarContainer" class="p-2 flex flex-column flex-center gap-2 h-full w-full relative">
                <vue-avatar
                  v-show="imageLoaded"
                  ref="avatar"
                  :border="10"
                  :borderRadius="200"
                  :height="avatarContainerSize"
                  :placeholderSvg="placeholder_pp"
                  :scale="ppScale"
                  :width="avatarContainerSize"
                  @vue-avatar-editor:image-ready="onImageLoad"/>

                <v-btn v-if="!imageLoaded" class="w-full" for="pp-input" icon
                       rounded="lg" size="x-large" tag="label">
                  <v-icon size="48">mdi-upload</v-icon>
                </v-btn>

                <div v-if="avatarLoading" class="absolute inset-0 flex flex-center flex-col p-2">
                  <v-progress-circular color="secondary" indeterminate size="64"/>
                  <div class="text-center m-6 p-2 bg-white">
                    Veuillez patienter, cette opération peut prendre quelques secondes
                  </div>

                </div>

                <div class="w-full px-2">
                  <v-slider v-if="imageLoaded" v-model="ppScale" max="3" min="0.5"
                            step="0.1"/>
                </div>

                <div class="flex gap-2 w-full justify-end">
                  <v-btn variant="text" @click="isActive.value = false; imageLoaded = false">
                    Annuler
                  </v-btn>
                  <v-btn v-if="imageLoaded" color="secondary" variant="text"
                         @click="uploadPP().then(() => isActive.value = false)">
                    Enregistrer
                  </v-btn>

                  <v-btn v-else color="secondary" variant="text"
                         @click="deletePP().then(() => isActive.value = false)">
                    Supprimer la photo
                  </v-btn>
                </div>

              </div>
            </v-card>
          </template>
        </v-dialog>

        <v-dialog v-model="error_upload" persistent>
          <v-card>
            <v-card-title class="text-red-500">
              Erreur
            </v-card-title>
            <v-card-text>
              Une erreur est survenue lors de l'envoi de la photo de profil
            </v-card-text>
            <v-card-actions>
              <v-spacer/>
              <v-btn @click="error_upload = false">
                Fermer
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <div>

        </div>
        <!--        <form class="absolute -top-[100vh]">-->
        <!--          <input id="ppInput" ref="ppInput" accept="image/*" class="absolute -top-full -left-full" type="file" @change="uploadPP"/>-->
        <!--        </form>-->
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
          <v-img :transition="false" class="h-6 w-6" src="@/assets/honey.webp"/>
        </div>
      </div>
    </div>

    <!--    <v-btn class="mt-4" size="large" variant="tonal" @click="router.push('stats')">-->
    <!--      <v-icon>mdi-chart-bar</v-icon>-->
    <!--      Statistiques-->
    <!--    </v-btn>-->

    <v-btn v-if="userStore.staffRoles && userStore.staffRoles.length > 0" class="mt-4"
           color="green" size="large" variant="tonal" @click="router.push('staff')">
      <v-icon>mdi-account-group</v-icon>
      Espace staffeur
    </v-btn>

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

