<script setup lang="ts">
import ScoreLine from "@/views/scoreboard/ScoreLine.vue";
import {useStorage} from "@vueuse/core";
import axios from "axios";
import {inject, ref} from "vue";
import {useUserStore} from "@/stores/user_store";
import {storeToRefs} from "pinia";
import {offlineKey} from "@/router/keys";
import {useScoreboardStore} from "@/stores/scoreboard_store";

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

const {scoreboard} = storeToRefs(useScoreboardStore())
const {updateScoreboard} = useScoreboardStore()

updateScoreboard().then((done) => {
  if (!done && !useScoreboardStore().loaded) {
    if (inject(offlineKey)?.offline.value) {
      alert("Vous êtes hors ligne, vous ne pouvez pas récupérer les données du classement." +
        "Veuillez vous connecter à internet pour récupérer les données du classement.")
      return
    }
    alert("Une erreur est survenue lors de la récupération des données du classement, veuillez réessayer plus tard.")
  }
})

</script>

<template>
  <div class="flex flex-col gap-4 mb-2">

    <h2 v-if="scoreboard == undefined" class="text-center text-2xl mt-4">
      Chargement...
    </h2>

    <h2 v-else-if="scoreboard.length == 0" class="text-center text-2xl mt-4">
      Personne n'a encore de points, soyez le premier !
    </h2>

    <ScoreLine class="rounded-2xl py-2 elevation-2"
               v-else
               v-for="user in scoreboard"
               :key="user.rank"
               v-bind="user"
               :class="user.rank <= 3 ? 'bg-red-500 *:text-white' : 'bg-white'"/>
  </div>

  <v-bottom-navigation height="124" class="!fixed bottom-0 rounded-t-xl" elevation="18">
    <score-line :score="score" :name="name" :rank="rank"
                class="bg-white rounded-t-xl"/>
  </v-bottom-navigation>
</template>
