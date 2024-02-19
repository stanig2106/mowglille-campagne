<script lang="ts" setup>

import router from "@/router";
import axios from "axios";
import {inject, ref, watch} from "vue";
import {doItOnline} from "@/router/offline";
import {useUserStore} from "@/stores/user_store";
import {storeToRefs} from "pinia";
import {computedWithControl} from "@vueuse/core";
import {informShowKey} from "@/router/keys";

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

const {notification_preferences} = storeToRefs(useUserStore())
watch(notification_preferences, (value, oldValue) => {
  if (value == undefined || oldValue == undefined || value.join() === oldValue.join())
    return

  if (value.find(v => v === "CUSTOM") === undefined && oldValue.find(v => v === "CUSTOM") !== undefined)
    inform?.("Notifications", "Les notifications personnalisées sont des notifications " +
      "qui vous sont directement adressées. Nous vous conseillons de les activer pour ne pas " +
      "manquer d'informations importantes.")

  doItOnline({
    method: "post", url: "/notification/update_status",
    data: {notifications: notification_preferences.value}
  }, {
    title: "Mise à jour des notifications",
    message: "Changement de vos paramètres de notifications",
  }, "notifications_update")
})

const notificationDisabled = computedWithControl(() => {
}, () => "Notification" in window &&
  Notification.permission === "denied")
setInterval(notificationDisabled.trigger, 5000)

const inform = inject(informShowKey)

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
        <h4>
          Notifications
        </h4>
        <div class="flex flex-col mb-8">
          <v-switch v-model="notification_preferences"
                    :disabled="notificationDisabled" color="secondary"
                    density="comfortable" hide-details
                    label="Notification d'évents" value="EVENTS"
          />
          <v-switch v-model="notification_preferences"
                    :disabled="notificationDisabled" color="secondary"
                    density="comfortable" hide-details
                    label="Notification de jeu" value="GAMES"
          />
          <v-switch v-model="notification_preferences"
                    :disabled="notificationDisabled" color="secondary"
                    density="comfortable" hide-details
                    label="Notification personnalisé" value="CUSTOM"
          />

          <p v-if="notificationDisabled" class="text-red-500">
            Vous avez désactivé les notifications dans les paramètres. Vous ne pourrez pas recevoir de notifications.
          </p>
        </div>

        <v-btn class="w-full mb-2" color="red" size="large" variant="text">
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
