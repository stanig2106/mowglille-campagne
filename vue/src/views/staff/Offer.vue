<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, ref, watch} from "vue";
import router from "@/router";
import FindUser from "@/components/FindUser.vue";
import {User} from "@/stores/users_store";
import Chest, {Rarity} from "@/views/collection/Chest.vue";
import {chestRarities} from "@/views/collection/chest";
import axios from "axios";
import {useOnline} from "@vueuse/core";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("CUSTOM_SCORE"))
  router.replace("/")

const user = ref(null as User | null)

const selected_chest = ref([] as Rarity[])

function select_chest(rarity: Rarity) {
  if (selected_chest.value.includes(rarity))
    selected_chest.value = selected_chest.value.filter(r => r != rarity)
  else
    selected_chest.value.push(rarity)
}

const quantity = ref(undefined as number | undefined)
const reason = ref("")

function reset() {
  selected_chest.value = []
  user.value = null
  quantity.value = undefined
}

const done = ref(false)
const error = ref(false)
const offline_cached = ref(false)

const online = useOnline()
watch(user, async () => {
  if (user.value != null) {
    if (reason.value.length == 0 || !quantity.value && selected_chest.value.length == 0) {
      error.value = true
      return
    }
    if (online.value)
      axios.post("/staff/offer", {
        reason: reason.value,
        user: user.value.publicToken,
        quantity: quantity.value,
        chests: selected_chest.value
      }).then(() => done.value = true)
        .catch(() => error.value = true)
    else {
      done.value = true
      offline_cached.value = true
    }

  }
})

watch(done, () => {
  if (!done)
    reset()
})


</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <v-card title="Motif" variant="text">
      <v-card-text>
        <v-text-field v-model="reason" hide-details
                      placeholder="Entrez un motif clair"
                      variant="solo-filled"/>
      </v-card-text>
    </v-card>


    <v-card title="Quantité de miel à offrir" variant="text">
      <v-card-text>
        <v-text-field v-model.number="quantity" hide-details
                      placeholder="Entrez une quantité"
                      suffix="Miels" variant="solo-filled"/>
      </v-card-text>
    </v-card>

    <v-card title="Inclure un coffre dans le dons" variant="text">
      <v-card-text>
        <div class="flex justify-between gap-6">
          <v-card v-for="rarity in chestRarities" :key="rarity"
                  :variant="selected_chest.includes(rarity) ? 'tonal' : 'elevated'"
                  class="focus:bg-inherit"
                  elevation="4"
                  @click="() => select_chest(rarity)">
            <chest :rarity="rarity"/>
          </v-card>
        </div>
      </v-card-text>
    </v-card>

    <find-user :key="user?.publicToken" v-model="user" class="w-full h-full" hide-cancel
               variant="text"/>


    <v-dialog v-model="done">
      <v-card :title="offline_cached ? 'Vous êtes hors-ligne' : 'Succès'">
        <v-card-text class="flex flex-col gap-4 items-center text-center !text-xl !pt-6">
          <template v-if="offline_cached">
            <v-icon color="secondary" size="x-large">mdi-table-arrow-up</v-icon>
            Votre demande à bien été pris en compte, dés que vous serez connecter à internet,
            {{ user!.firstName }} recevras les {{ quantity }} miels et
            {{ selected_chest.length }} coffres
          </template>

          <template v-else>
            <v-icon color="green" size="x-large">mdi-check-circle</v-icon>
            Les {{ quantity }} miels et {{ selected_chest.length }} coffres ont bien été
            offert à {{ user!.firstName }}
          </template>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <v-btn @click="done = false">
            Ok
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="error">
      <v-card title="Une erreur est survenue">
        <v-card-text class="flex flex-col gap-4 items-center text-center !text-xl !pt-6">
          <v-icon color="red" size="x-large">mdi-alert-circle</v-icon>
          <template v-if="reason.length == 0">
            Vous devez preciser un motif !
          </template>
          <template v-else-if="!quantity && selected_chest.length == 0">
            Sélectionnez au moins un élement à offrir
          </template>
          <template v-else>
            Veuillez réessayer
          </template>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <v-btn @click="() => {error = false; user = null}">
            Réessayer
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>


  </div>
</template>
