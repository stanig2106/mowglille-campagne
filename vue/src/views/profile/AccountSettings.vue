<script lang="ts" setup>

import router from "@/router";
import axios from "axios";
import {ref} from "vue";

const loading = ref(false)

async function deleteAccount() {
  loading.value = true
  await axios.delete("/api/user")
    .then(() => {
      localStorage.removeItem("token")
      router.push("/")
    }).catch(() => {
      loading.value = false
    })
}

</script>

<template>
  <v-dialog activator="parent">
    <v-card>
      <v-card-title>
        <h2 class="text-2xl text-center mt-4">
          Paramètres du compte
        </h2>
      </v-card-title>
      <v-card-text>
        <v-btn class="w-full mb-2" color="red" size="large" variant="tonal">
          <v-icon>mdi-delete</v-icon>
          Supprimer le compte

          <v-dialog activator="parent" persistent>
            <template #default="{isActive}">
              <v-card>
                <v-card-title>
                  <h2 class="text-2xl text-center mt-4">
                    Supprimer le compte
                  </h2>
                </v-card-title>
                <v-card-text>
                  <h3 class="text-lg">
                    Êtes vous sûr de vouloir supprimer votre compte ? <br> <br>
                  </h3>
                  <p>
                    Tout vos scores et votre progression seront perdus. Vous ne pourrez pas revenir en arrière. <br>
                    <br>
                    Nous nous engageons à supprimer toutes vos données personnelles. <br>
                  </p>

                  <div class="flex justify-between gap-2 w-full >:w-full >:flex-1 mt-4">
                    <v-btn :disabled="loading" size="large"
                           variant="tonal" @click="isActive.value = false">
                      <v-icon>mdi-arrow-left</v-icon>
                      Annuler
                    </v-btn>


                    <v-btn :loading="loading" color="red" size="large" variant="tonal"
                           @click="deleteAccount">
                      <v-icon>mdi-delete</v-icon>
                      Oui
                    </v-btn>
                  </div>
                </v-card-text>
              </v-card>
            </template>
          </v-dialog>
        </v-btn>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
