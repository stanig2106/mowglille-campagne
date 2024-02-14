<script lang="ts" setup>

import OpenChest from "@/components/OpenChest.vue";
import {ref} from "vue";
import ChestHistory from "@/views/collection/ChestHistory.vue";
import PieceViewer from "@/views/collection/PieceViewer.vue";

const chests = ref([1])

const chestHistories = ref([])

const opening = ref(false)

</script>

<template>
  <div class="bg-white rounded-2xl p-4 flex flex-col gap-2 elevation-2">
    <h2 class="text-xl flex justify-between items-center gap-2">
      Vos coffres à ouvrir
      <v-btn density="comfortable" icon rounded="lg" variant="flat">
        <v-icon>mdi-history</v-icon>

        <v-dialog activator="parent" close-on-back>
          <template #default="{isActive}">
            <div class="h-[80vh] w-[90vw] bg-white elevation-4 rounded-2xl p-4 flex flex-col justify-between">
              <div class="flex flex-col gap-4">
                <h2 class="text-xl">
                  Historique des coffres
                </h2>

                <chest-history v-for="chestHistory in chestHistories"
                               :key="chestHistory" :chestHistory="chestHistory"/>
                <h4 v-if="chestHistories.length == 0" class="text-center w-full px-4 mt-4">
                  Vous n'avez pas encore ouvert de coffre, ouvrez-en pour voir l'historique !
                </h4>
              </div>


              <v-btn class="w-full" variant="tonal" @click="isActive.value = false">
                Fermer
              </v-btn>
            </div>
          </template>
        </v-dialog>
      </v-btn>
    </h2>

    <div class="flex gap-4 overflow-x-auto">
      <v-icon v-for="chest in chests" :key="chest" size="96" @click="opening = true">
        mdi-treasure-chest
      </v-icon>
      <h4 v-if="chests.length == 0" class="text-center w-full px-4">
        Vous n'avez pas de coffre à ouvrir, faites des activités pour en gagner !
      </h4>

      <open-chest v-if="opening" rarity="epic" @done="opening = false; chests = []"/>
    </div>
  </div>

  <div class="bg-white rounded-t-2xl p-4 flex flex-col mt-4 elevation-2 h-full gap-6 relative">
    <h2 class="text-xl">
      Votre collection
    </h2>

    <h3>
      Vous avez aucune pièce pour le moment, ouvrez des coffres pour en gagner !
    </h3>

<!--    <piece-viewer class="w-full h-full"/>-->


  </div>

  <!--  <open-chest rarity="epic"/>-->

</template>

