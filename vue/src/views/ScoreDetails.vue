<script setup lang="ts">
import ScoreLine from "@/views/scoreDetails/ScoreLine.vue";
import CurrentScore from "@/views/scoreboard/ScoreLine.vue";
import {useStorage} from "@vueuse/core";
import axios from "axios";
import {ref} from "vue";

const score = useStorage("score", "-" as string | number)
axios.get("/score").then(({data}) => score.value = data.score)

const name = useStorage("name", "-" as string)
axios.get("/name").then(({data}) => name.value = data.name)

const rank = useStorage("rank", "-" as string | number)
axios.get("/rank").then(({data}) => rank.value = data.rank)

const score_details = ref(undefined as undefined | { name: string, score: number, rank: number }[])
axios.get("/score_details").then(({data}) => score_details.value = data.score_details)

</script>

<template>
  <div class="flex flex-col gap-4 mb-2">
    <h2 v-if="score_details == undefined" class="text-center text-2xl mt-4">
      Chargement...
    </h2>

    <h2 v-else-if="score_details.length == 0" class="text-center text-2xl mt-4 px-4">
      Vous n'avez pas encore de points, gagnez des points en participant aux activités ou en jouant aux jeux !
    </h2>

    <score-line v-else
                class="rounded-2xl py-2 bg-white elevation-2"/>
  </div>

  <v-bottom-navigation height="124" class="!fixed bottom-0 rounded-t-xl" elevation="18">
    <current-score :score="score" :name="name" :rank="rank"/>
  </v-bottom-navigation>
</template>
