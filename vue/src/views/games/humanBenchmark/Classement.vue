<script lang="ts" setup>
import {computed, onMounted, Ref, ref, watch} from "vue";
import {Game, gameNames, games} from "@/views/games/humanBenchmark/humanBenchmark";
import {saveScore} from "@/views/games/Score";

const selected_game_index = ref(0);

const selected_game: Ref<Game> = computed(() => games[selected_game_index.value])
onMounted(() => {
  saveScore("human_benchmark_reaction_time", 14)
})

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col
             elevation-2 h-full gap-4 relative">

    <h2 class="text-2xl text-center relative">
      Classement
      <v-btn class="absolute right-0 -top-0.5" density="comfortable" icon rounded="lg" variant="text">
        <v-icon>
          mdi-information
        </v-icon>
      </v-btn>
    </h2>

    <v-slide-group
      v-model="selected_game_index"
      center-active class="-ml-4 -mr-4 >:px-4"
      mandatory
    >
      <v-slide-group-item
        v-for="game in games"
        :key="game"
        v-slot="{ isSelected, toggle }"
      >
        <v-btn
          :variant="isSelected ? 'tonal' : 'outlined'"
          class="mx-2"
          @click="toggle"
        >
          {{ gameNames[game] }}
        </v-btn>
      </v-slide-group-item>
    </v-slide-group>

  </div>

</template>

<style lang="scss" scoped>

</style>
