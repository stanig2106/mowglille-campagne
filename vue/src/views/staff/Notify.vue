<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, inject, nextTick, ref, watch} from "vue";
import router from "@/router";
import FindUser from "@/components/FindUser.vue";
import {User} from "@/stores/users_store";
import {informShowKey} from "@/router/keys";
import {doItOnline} from "@/router/offline";
import axios from "axios";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("NOTIFY"))
  router.replace("/")

const title = ref("")
const message = ref("")

const types = ['EVENTS', 'GAMES', 'CHALLENGES', 'CUSTOM'] as const

const type = ref("CUSTOM" as typeof types[number])

const user = ref(null as User | null)

const inform = inject(informShowKey)!

watch(() => user.value, async () => {
  if (user.value == null)
    return
  send(user.value)
  inform("Notification", "Le message a bien été envoyé")
  await nextTick(() => user.value = null)
})

function send(to?: User) {
  doItOnline({
    url: "/notifications/notify", method: "post",
    data: {
      title: title.value,
      message: message.value,
      type: type.value,
      to: to?.publicToken
    }
  }, {
    title: "Envoi de notification",
    message: "Envoi de " + title.value
  }).catch((e) =>
    inform("Erreur",
      "Impossible d'envoyer la notification : " +
      (e.response.data.error || e.message)))
}


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <div class="h-full">
      <v-text-field v-model="title" class="mb-4" hide-details label="Titre"/>
      <v-textarea v-model="message" class="mb-4" hide-details label="Message"/>

      <v-select v-model="type" :items="types" class="mb-4" hide-details
                item-text="type" item-value="type" label="Type"/>

      <v-btn :disabled="!title || !message" class="w-full">
        Envoyer à tous les étudiants
        <v-dialog activator="parent">
          <template #default="{isActive}">
            <v-card>
              <v-card-title>
                <h2 class="text-2xl text-center mt-4">
                  Confirmation
                </h2>
              </v-card-title>
              <v-card-text>
                <p>
                  Êtes-vous sûr de vouloir envoyer ce message à tous les étudiants ?
                </p>
              </v-card-text>
              <v-card-actions class="flex justify-end">
                <v-btn color="" @click="isActive.value = false">
                  Annuler
                </v-btn>
                <v-btn color="secondary" @click="isActive.value = false; send()">
                  Confirmer
                </v-btn>
              </v-card-actions>
            </v-card>
          </template>
        </v-dialog>
      </v-btn>

      <p class="flex justify-center mt-8">
        OU
      </p>

      <find-user :key="user?.publicToken" v-model="user" :disabled="!title || !message"
                 class="mt-4" hide-cancel must-be-online variant="text"/>
    </div>
  </div>
</template>
