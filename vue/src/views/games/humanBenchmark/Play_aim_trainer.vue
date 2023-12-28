<script lang="ts" setup>

import {computed, ref} from "vue";
import {gameNames} from "./humanBenchmark";

const todo = 30;
const started = ref(false);
const results = ref([] as number[])
const done = ref(false)
const timeout = ref<NodeJS.Timeout | null>(null)
const time_value = ref(3)

const top = ref(50)
const left = ref(50)
const last_time = ref(0)

function set_random_position() {
  top.value = Math.random() * 70 + 15
  left.value = Math.random() * 80 + 5
}

function nextStep() {
  if (!started.value) {
    if (timeout.value)
      return
    done.value = false
    timeout.value = setTimeout(() => {
      time_value.value--
      timeout.value = setTimeout(() => {
        time_value.value--
        timeout.value = setTimeout(() => {
          time_value.value = 3
          timeout.value = null
          started.value = true
          set_random_position()
          last_time.value = Date.now()
        }, 1000)
      }, 1000)
    }, 1000)
    results.value = []
    return
  }
  if (results.value.length >= todo - 1) {
    done.value = true
    setTimeout(() => {
      started.value = false
    }, 1000)
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
          items-center elevation-2 h-full gap-4 relative bg-secondary"
       @click="!started && nextStep()">
    <template v-if="timeout">
      <span class="text-6xl">
        {{ time_value }}
      </span>
    </template>
    <template v-else>

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
      flex flex-col gap-6">
        Toucher {{ todo }} cibles le plus rapidement possible. <br>
        Cliquez pour commencer.
      </span>
      </div>
      <div v-if="done" class="flex flex-col justify-center">
        <div class="text-4xl text-white px-4 text-center items-center
      flex flex-col gap-6 mb-6">
          {{ gameNames['aim_trainer'] }}
        </div>
        <div class="text-xl text-white px-4 text-center items-center
                  flex flex-col gap-6">
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
            Cliquer pour recommencer.
          </div>
        </div>


      </div>
    </template>

    <v-icon v-if="started && !done"
            :style="{ top: top + '%', left: left + '%'}"
            class="-translate-x-1/2 -translate-y-1/2 absolute" color="primary" size="112px"
            @pointerdown="nextStep">
      mdi-bullseye
    </v-icon>
  </div>

</template>

