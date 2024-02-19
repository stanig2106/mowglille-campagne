<script lang="ts" setup>
import {computed, Ref, ref, watch} from "vue";
import {Game, gameNames, games} from "@/views/games/humanBenchmark/humanBenchmark";
import {GameScoreboard, useGameScoreboardStore} from "@/stores/game_classements_store";
import default_picture from "@/assets/default_pp.png";
import {dateToS} from "@/views/games/safariSprint/core/utils";
import honey from "@/assets/honey.png";
import {doItOnline} from "@/router/offline";

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

const game_unit = {
  aim_trainer: "s",
  chimp_test: "",
  reaction_time: "ms",
  visual_memory: "",
  verbal_memory: "",
  number_memory: "",
  sequence_memory: "",
} satisfies Record<Game, string>


function congratulate(score: GameScoreboard[number]) {
  doItOnline({
    method: "post", url: "/games/congratulate",
    data: {score_id: score.id}
  }, {
    title: "Félicitation",
    message: "Félicitation envoyée à " + score.name,
  })
  score.congratulated = true
}
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

    <v-carousel v-model="selected_game_index" :continuous="false" :show-arrows="false" class="flex-grow >:!h-full"
                hide-delimiters>
      <v-carousel-item v-for="game in games" :key="game">
        <div v-if="game_classements_store.scoreboards?.[long_selected_game(game)]"
             class="h-full overflow-y-auto overflow-x-hidden flex flex-col gap-2 px-2">
          <v-card v-for="score in game_classements_store.scoreboards[long_selected_game(game)]" :color="score.you ? 'orange' : ''" rounded="lg"
                  variant="tonal"
                  @click="">
            <v-dialog activator="parent">
              <v-card elevation="2">
                <v-card-title>
                  #{{ score.rank }} - {{ score.name }}
                </v-card-title>
                <v-card-text>
                  <div class="flex flex-col justify-center items-center mb-2">
                    <v-img :src="score.pp ?? default_picture" height="100" width="100"/>
                    <h3 class="mt-2">
                      Score: {{ score.score }} {{ game_unit[game] }}
                    </h3>
                    <h5 class="text-muted">
                      {{ dateToS(score.date) }}
                    </h5>
                  </div>
                  <div>
                    <div>
                      Nombre d'essaies: {{ score.tries }}
                    </div>
                    <div>
                      Moyenne: {{ score.average }} {{ game_unit[game] }}
                    </div>
                  </div>
                </v-card-text>
                <v-card-actions v-if="!score.you" class="flex justify-end">
                  <v-btn v-if="!score.you" :disabled="score.congratulated"
                         @click="congratulate(score)">
                    <v-snackbar :timeout="2000" activator="parent" close-on-content-click
                                transition="fade-transition">
                      1 miel à été envoyé à {{ score.name }}
                    </v-snackbar>
                    <v-img :src="honey" class="mr-1 h-4 w-4"/>
                    Féliciter
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <div class="flex justify-between w-full h-full items-center px-4 py-1">
              <div class="flex gap-2 items-center w-full">
                <div class="rounded-full overflow-hidden">
                  <v-img :src="score.pp ?? default_picture" height="48" width="48"/>
                </div>

                <div class="flex flex-col gap-1 justify-center flex-1">
                  <div class="text-3xl flex justify-between >:one-line">
                    <div>
                      {{ "#" + score.rank }}
                    </div>
                    <div>
                      {{ score.score }} {{ game_unit[game] }}
                    </div>
                  </div>
                  <div class="text-lg text-muted >:one-line">
                    {{ score.name }}
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
