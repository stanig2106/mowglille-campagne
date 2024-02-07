<script lang="ts" setup>
import ScoreLine from "@/views/scoreboard/ScoreLine.vue";
import {useStorage} from "@vueuse/core";
import axios from "axios";
import {inject, ref} from "vue";
import {useUserStore} from "@/stores/user_store";
import {storeToRefs} from "pinia";
import {useScoreboardStore} from "@/stores/scoreboard_store";
import {useOffline} from "@/router/offline";

const {name, score, rank, pp} = storeToRefs(useUserStore())
const {updateUser} = useUserStore()

updateUser().then((done) => {
  if (!done && !useUserStore().loaded) {
    if (useOffline().offline.value) {
      alert("Vous êtes hors ligne, vous ne pouvez pas récupérer vos données." +
        "Veuillez vous connecter à internet pour récupérer vos données.")
      return
    }
    alert("Une erreur est survenue lors de la récupération de vos données, veuillez réessayer plus tard.")
  }
})

const {scoreboard} = storeToRefs(useScoreboardStore())
const {updateScoreboard} = useScoreboardStore()

updateScoreboard()

</script>

<template>
  <div class="flex flex-col gap-4 mb-2">

    <h2 v-if="scoreboard == undefined" class="text-center text-2xl mt-4">
      Chargement...
    </h2>

    <h2 v-else-if="scoreboard.length == 0" class="text-center text-2xl mt-4">
      Personne n'a encore de points, soyez le premier !
    </h2>

    <ScoreLine v-for="user in scoreboard"
               v-else
               :key="user.rank"
               :class="user.rank <= 3 ? 'bg-red-400 *:text-white' : 'bg-white'"

               :profile_picture="user.pp ?? null"
               class="rounded-2xl py-2 elevation-2"
               v-bind="user"/>
  </div>

  <v-bottom-navigation class="!fixed bottom-0 rounded-t-xl" elevation="18" height="124">
    <score-line :name="name" :profile_picture="pp ?? null" :rank="rank"
                :score="score"
                class="bg-white rounded-t-xl"/>
  </v-bottom-navigation>
</template>
