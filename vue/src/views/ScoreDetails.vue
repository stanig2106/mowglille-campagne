<script setup lang="ts">
import ScoreLine from "@/views/scoreDetails/ScoreLine.vue";
import CurrentScore from "@/views/scoreboard/ScoreLine.vue";
import {useStorage} from "@vueuse/core";
import axios from "axios";
import {inject, ref} from "vue";
import {storeToRefs} from "pinia";
import {useUserStore} from "@/stores/user_store";
import {offlineKey} from "@/router/keys";
import {useScoreboardStore} from "@/stores/scoreboard_store";
import {useScoreDetailsStore} from "@/stores/score_details_store";

const {name, score, rank} = storeToRefs(useUserStore())
const {updateUser} = useUserStore()

updateUser().then((done) => {
  if (!done && !useUserStore().loaded) {
    if (inject(offlineKey)?.offline.value) {
      alert("Vous êtes hors ligne, vous ne pouvez pas récupérer vos données." +
        "Veuillez vous connecter à internet pour récupérer vos données.")
      return
    }
    alert("Une erreur est survenue lors de la récupération de vos données, veuillez réessayer plus tard.")
  }
})

const {scoreDetails} = storeToRefs(useScoreDetailsStore())
const {updateScoreDetails} = useScoreDetailsStore()

updateScoreDetails().then((done) => {

  if (!done && !useScoreDetailsStore().loaded) {
    if (inject(offlineKey)?.offline.value) {
      alert("Vous êtes hors ligne, vous ne pouvez pas récupérer les données." +
        "Veuillez vous connecter à internet pour récupérer les données.")
      return
    }
    alert("Une erreur est survenue lors de la récupération des données, veuillez réessayer plus tard.")
  }
})

</script>

<template>
  <div class="flex flex-col gap-4 mb-2">
    <h2 v-if="scoreDetails == undefined" class="text-center text-2xl mt-4">
      Chargement...
    </h2>

    <h2 v-else-if="scoreDetails.length == 0" class="text-center text-2xl mt-4 px-4">
      Vous n'avez pas encore de points, gagnez des points en participant aux activités ou en jouant aux jeux !
    </h2>

    <score-line v-else
                class="rounded-2xl py-2 bg-white elevation-2"/>
  </div>

  <v-bottom-navigation height="124" class="!fixed bottom-0 rounded-t-xl" elevation="18">
    <current-score :score="score" :name="name" :rank="rank"/>
  </v-bottom-navigation>
</template>
