<script lang="ts" setup>

import {computed, ref} from 'vue'
import {useChallengesStore} from "@/stores/challenges_store";
import ChallengeLine from "@/views/staff/ChallengeLine.vue";

const page = ref(1)

const titles = [
  "Défis flash",
  "Défis bzzz bzzz",
  "Défis mielleux au miel",
  "Défis de zinzin",
]

const cats = [
  'flash',
  'bzzz',
  'mielleux',
  'zinzin'
]

const challengeStore = useChallengesStore()
challengeStore.updateChallenges()

const challenges = computed(() => challengeStore.challenges?.filter(c => c.category == cats[page.value]))

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative">
    <div class="flex justify-between items-center mb-4">
      <v-btn :disabled="page == 0" icon rounded="lg" @click="page--">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <h3 class="text-xl text-center flex items-center">
        {{ titles[page] }}
      </h3>
      <v-btn :disabled="page == titles.length - 1" icon rounded="lg" @click="page++">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </div>
    <v-carousel v-model="page" :continuous="false" :show-arrows="false" class="flex-grow >:!h-full"
                hide-delimiters>
      <v-carousel-item v-for="index in titles.length" :key="index">


        <challenge-line v-for="challenge in challenges" :key="challenge.id"
                        :challenge="challenge" user-show class="mt-2"/>

        <div v-if="challenges == undefined || challenges.length == 0" class="h-full text-xl text-center mt-4">
          Aucun défi pour le moment, revenez plus tard !
        </div>
      </v-carousel-item>
    </v-carousel>

  </div>
</template>

