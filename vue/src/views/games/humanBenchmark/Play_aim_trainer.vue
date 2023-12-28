<script lang="ts" setup>

import {computed, ref} from "vue";
import {gameNames} from "./humanBenchmark";

const todo = 30;
const started = ref(false);
const results = ref([] as number[])
const done = ref(false)

const top = ref(50)
const left = ref(50)
const last_time = ref(0)

function set_random_position() {
  top.value = Math.random() * 70 + 15
  left.value = Math.random() * 80 + 5
}

function nextStep() {
  if (!started.value) {
    done.value = false
    started.value = true
    results.value = []
    last_time.value = Date.now()
    set_random_position()
    return
  }
  if (results.value.length >= todo - 1) {
    done.value = true
    started.value = false
    top.value = 50
    left.value = 50
    return
  }

  const result = Date.now() - last_time.value
  last_time.value = Date.now()
  set_random_position()
  results.value.push(result)
}

const sum = computed(() => results.value.reduce((a, b) => a + b, 0))
const average = computed(() => sum.value / results.value.length)

</script>

<template>


  <div class="rounded-t-2xl p-4 flex flex-col justify-center text-white
          items-center elevation-2 h-full gap-4 relative bg-secondary">
    <div v-if="started && !done"
         class="absolute top-4 w-full left-0 text-center
              text-white text-xl">
      Restant: {{ todo - results.length }}
    </div>
    <div v-if="!started && !done" class="flex flex-col justify-center">
      <div class="text-4xl text-white px-4 text-center items-center
      flex flex-col gap-6">
        {{ gameNames['aim_trainer'] }}
      </div>
      <span class="text-xl text-white px-4 text-center items-center
      flex flex-col gap-6 mt-[50vw]">
        Toucher {{ todo }} cibles le plus rapidement possible. <br>
        Cliquez sur cette cible pour commencer.
      </span>
    </div>
    <div v-if="done" class="flex flex-col justify-center">
      <div class="text-4xl text-white px-4 text-center items-center
      flex flex-col gap-6 translate-y-[40vw]">
        {{ gameNames['aim_trainer'] }}
      </div>
      <div class="text-xl text-white px-4 text-center items-center
                  flex flex-col gap-6 mt-[80vw]">
        <div>
          Vous avez touché {{ todo }} cibles en {{ (sum / 1000).toFixed(2) }} secondes.
        </div>
        <div>
          Votre temps moyen de réaction est de
          <span v-if="average < 1000">
            {{ Math.round(average) }} ms.
          </span>
          <span v-else>
            {{ (average / 1000).toFixed(2) }} s.
          </span>
        </div>
        <div>
          Votre score a été enregistré. <br>
          Cliquer sur la cible pour recommencer.
        </div>

      </div>


    </div>

    <v-icon :style="{ top: top + '%', left: left + '%'}"
            class="-translate-x-1/2 -translate-y-1/2 absolute"
            color="primary" size="112px"
            @pointerdown="nextStep">
      mdi-bullseye
    </v-icon>
  </div>

</template>

