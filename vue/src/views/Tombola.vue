<script lang="ts" setup>

import {storeToRefs} from "pinia";
import {useUserStore} from "@/stores/user_store";

const {tombola_ticket} = storeToRefs(useUserStore())
const {updateUser} = useUserStore()
updateUser()

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <template v-if="tombola_ticket">
      <div class="flex justify-center">
      <v-icon size="120" class="text-6xl text-green-600">
        mdi-ticket
      </v-icon>
      </div>
      <h2 class="text-2xl text-center">
        Vous avez le ticket n°{{ tombola_ticket }}
      </h2>
      <div class="text-center">
        Rendez vous ce soir au foyer pour le tirage au sort et pour gagner une switch lite !
      </div>
    </template>

    <template v-else>
      <h2 class="text-2xl text-center">
        Vous n'avez pas encore de ticket
      </h2>
      <div class="text-center">
        Allez voir un mowgu pour en obtenir un et tenter de gagner une switch lite !
      </div>

    </template>
  </div>


</template>
