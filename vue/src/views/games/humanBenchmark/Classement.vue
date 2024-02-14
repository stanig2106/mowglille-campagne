<script lang="ts" setup>
import {computed, Ref, ref, watch} from "vue";
import {Game, gameNames, games} from "@/views/games/humanBenchmark/humanBenchmark";
import {useGameScoreboardStore} from "@/stores/game_classements_store";
import default_picture from "@/assets/default_pp.png";

const selected_game_index = ref(0);

const selected_game: Ref<Game> = computed(() => games[selected_game_index.value])

function long_selected_game(game: Game) {
  return "human_benchmark_" + game
}

const game_classements_store = useGameScoreboardStore()

watch(selected_game, game => {
  if (game)
    game_classements_store.updateScoreboard(long_selected_game(game))
}, {immediate: true})

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

    <v-carousel :show-arrows="false" hide-delimiters v-model="selected_game_index" :continuous="false"
                class="flex-grow >:!h-full">
      <v-carousel-item v-for="game in games" :key="game">
        <div class="h-full overflow-y-auto overflow-x-hidden flex flex-col gap-2 px-2"
             v-if="game_classements_store.scoreboards?.[long_selected_game(game)]">
          <v-card variant="tonal" rounded="lg" :color="score.you ? 'orange' : ''"
                  v-for="score in game_classements_store.scoreboards[long_selected_game(game)]">
            <div class="flex justify-between w-full h-full items-center px-4 py-1">
              <div class="flex gap-2 items-center w-full">
                <div class="rounded-full overflow-hidden">
                  <v-img :src="score.pp ?? default_picture" height="48" width="48"/>
                </div>

                <div class="flex flex-col gap-1 justify-center flex-1">
                  <div class="text-3xl flex justify-between">
                    <div>
                      {{ "#" + score.rank }}
                    </div>
                    <div>
                      {{ score.score }}
                    </div>
                  </div>
                  <div class="flex text-lg text-muted justify-between">
                    <div>
                      {{ score.name }}
                    </div>
                    <div v-if="score.date.toLocaleDateString">
                      {{ score.date.toLocaleDateString().slice(0, -5) }}, {{ score.date.toLocaleTimeString().slice(0, -3) }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </v-card>

          <h2 v-if="game_classements_store.scoreboards[long_selected_game(game)].length == 0"
              class="text-center text-2xl mt-4">
            Personne n'a encore de points, soyez le premier !
          </h2>
        </div>

        <h2 v-else class="text-center text-2xl mt-4">
          Chargement...
        </h2>
      </v-carousel-item>
    </v-carousel>


  </div>

</template>

<style lang="scss" scoped>

</style>
