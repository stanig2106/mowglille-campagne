<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, inject, reactive} from "vue";
import {informShowKey} from "@/router/keys";
import axios from "axios";
import {doItOnline} from "@/router/offline";

const currentUser = useUserStore()
currentUser.updateUser()

const d_value = {
  id: null,
  name: "",
  description: "",
  score: null,
  is_flash: false,
  start_date: null,
  end_date: null,
  location: null,
  amount: null,
}

const challenge = reactive({...d_value})

const informShow = inject(informShowKey)!

async function submit() {
  if (challenge.name.length == 0 || challenge.description.length == 0)
    return onError("Veuillez remplir tous les champs")

  if (challenge.score == null || challenge.score <= 0)
    return onError("Le score doit être supérieur à 0")

  if ((challenge.amount || 1) <= 0)
    return onError("Le nombre de validation max doit être supérieur à 0")

  if (challenge.is_flash && (challenge.start_date == null || challenge.end_date == null))
    return onError("Veuillez remplir les dates de début et de fin si le défi est un défi flash")

  if (challenge.start_date != null && challenge.end_date != null && challenge.start_date >= challenge.end_date)
    return onError("La date de début doit être inférieure à la date de fin")

  doItOnline({
    method: "post", url: "/challenges",
    data: {...challenge}
  }, {
    title: "Créer un défi",
    message: "Création du défi " + challenge.name
  })?.then(() => {
    // reload
  })

  Object.assign(challenge, d_value)

  return Promise.resolve()
}

function onError(message: string) {
  informShow("Erreur", message)
  return Promise.reject(message)
}
</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <v-btn color="secondary" size="large">
      Créer un challenge
      <v-dialog activator="parent" persistent>
        <template #default="{isActive}">
          <v-card>
            <v-card-title>
              <span class="headline">Créer un challenge</span>
            </v-card-title>
            <v-card-text>
              <v-text-field v-model="challenge.name" label="Nom du challenge" required/>
              <v-text-field v-model="challenge.description" label="Description" required/>
              <v-text-field v-model.number="challenge.score" label="Score" required/>
              <v-checkbox v-model="challenge.is_flash" label="Défi flash (Cacher le défi jusqu'au début de ce dernier)"/>

              <v-text-field v-model="challenge.start_date" label="Date et heure de début" type="datetime-local"/>
              <v-text-field v-model="challenge.end_date" label="Date et heure de fin" type="datetime-local"/>


              <v-text-field v-model="challenge.location" label="Lieu (optionnel)"/>
              <v-text-field v-model.number="challenge.amount" label="Nombre de validation max (optionnel)"/>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn @click="isActive.value = false">Annuler</v-btn>
              <v-btn color="secondary"
                     @click="submit().then(() => isActive.value = false)">Créer
              </v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-btn>
  </div>
</template>
