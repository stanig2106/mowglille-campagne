<script setup lang="ts">
import ScoreLine from "@/views/scoreboard/ScoreLine.vue";
import {useStorage} from "@vueuse/core";
import axios from "axios";
import {ref} from "vue";

const score = useStorage("score", "-" as string | number)
axios.get("/score").then(({data}) => score.value = data.score)

const name = useStorage("name", "-" as string)
axios.get("/name").then(({data}) => name.value = data.name)

const rank = useStorage("rank", "-" as string | number)
axios.get("/rank").then(({data}) => rank.value = data.rank)

const scoreboard = ref(undefined as undefined | { name: string, score: number, rank: number }[])
axios.get("/scoreboard").then(({data}) => scoreboard.value = data.scoreboard)

</script>

<template>
  <div class="flex flex-col gap-4 mb-2">

    <h2 v-if="scoreboard == null" class="text-center text-2xl mt-4">
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
    <score-line :score="score" :name="name" :rank="rank" class="bg-white rounded-t-xl"/>
  </v-bottom-navigation>
</template>
