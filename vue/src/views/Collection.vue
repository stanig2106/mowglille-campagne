<script lang="ts" setup>
import OpenChest from "@/components/OpenChest.vue";
import {computed, ref, watch} from "vue";
import ChestHistory from "@/views/collection/ChestHistory.vue";
import Chest from "@/views/collection/Chest.vue";
import {ChestRewards, Chests, useChestsStore} from "@/stores/chests_store";
import {doItOnline} from "@/router/offline";

const chestHistories = ref([] as Chests)

const chestsStore = useChestsStore()
chestsStore.updateChests()

const opening = ref(false as Chests[number] | false)

watch(opening, (value) => {
  if (!value)
    return
  chestHistories.value.push(value)

  doItOnline({
    url: "/chests/open/" + value.id, method: "post"
  }, {
    title: "Ouverture d'un coffre",
    message: "Ouverture du coffre " + value.rarity
  }).then(chestsStore.updateChests)
})

const opened_ids = ref([] as number[])


let reward = ref([] as ChestRewards)
watch(opening, () => {
  if (!opening.value || !chestsStore.rewards)
    return

  reward.value = []

  const rarity = ["rare", "epic", "legendary"] as const
  rarity.forEach((r) => {
    if (rarity.indexOf((opening.value as Chests[number]).rarity) >= rarity.indexOf(r))
      if (chestsStore.rewards![r].length > 0)
        reward.value.push({
          type: "piece", rarity: r,
          id: chestsStore.rewards![r].shift()!
        })
      else
        reward.value.push({
          type: "score",
          amount: rarity.indexOf(r) * 100 + 100
        })
  })

  return reward
})

</script>

<template>
  <div class="flex flex-col gap-2 h-full">
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
                                 :key="chestHistory.id" :chestHistory="chestHistory"/>
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
        <chest v-for="chest in chestsStore.chests" v-show="!opened_ids.includes(chest.id)"
               :key="chest.id" :rarity="chest.rarity" size="96"
               @click="opening = chest; opened_ids.push(chest.id)"/>
        <h4 v-if="!chestsStore.chests?.length" class="text-center w-full px-4">
          Vous n'avez pas de coffre à ouvrir, faites des activités pour en gagner !
        </h4>

        <open-chest v-if="opening" :rarity="opening.rarity"
                    :reward="reward"
                    @done="opening = false"/>
      </div>
    </div>

    <div class="bg-white rounded-t-2xl mt-4 p-4 pb-8 flex flex-col elevation-2 gap-6 flex-1">
      <h2 class="text-xl">
        Votre collection
      </h2>


      <div class="h-full relative">
        <img class="rounded-2xl w-full opacity-0"
             src="/collections/20.png"/>

        <img v-for="piece in chestsStore.collections" :key="piece"
             :src="`/collections/${piece}.png`"
             class="rounded-2xl absolute w-full top-0"/>
      </div>
      <div v-if="chestsStore.winner == false" class="text-center text-xl">
        Complétez le puzzle en premier pour gagner une switch !
      </div>
      <div v-else-if="chestsStore.winner == true" class="text-center text-xl">
        Vous avez completer le puzzle en premier et remportez la switch !
      </div>
      <div v-else class="text-center text-xl">
        {{ chestsStore.winner }} a completer le puzzle en premier et remporte la switch ! <br>
        Vous pouvez toujours completer le puzzle pour gagner 500 points !
      </div>

    </div>
  </div>


  <v-dialog v-if="chestsStore.winner && !opening" #default="{isActive}"
            :model-value="true">
    <v-card>
      <div class="p-6">
        <h2 v-if="chestsStore.winner == true" class="mb-4">
          Félicitation !
        </h2>
        <div v-if="chestsStore.winner == true">
          Vous êtes le premier à avoir completer le puzzle, rendez vous ce soir
          au foyer pour récupérer votre lot ! <br> <br>
          Si vous n'êtes pas disponible ce soir, contactez un Mowgu !
        </div>
        <div v-else>
          {{ chestsStore.winner }} a completer le puzzle en premier et remporte la switch ! <br>
          Vous pouvez toujours completer le puzzle pour gagner 500 points !
        </div>
      </div>

      <div class="flex justify-end p-2">
        <v-btn variant="text" @click="isActive.value = false">
          Fermer
        </v-btn>

      </div>
    </v-card>
  </v-dialog>
</template>

