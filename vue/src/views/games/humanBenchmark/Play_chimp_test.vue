<script lang="ts" setup>

import {computed, onMounted, ref, watch} from "vue";
import {gameNames} from "./humanBenchmark";

const started = ref(false);
const done = ref(false)

const round = ref(1)
const size = ref(5 * 8)

const user_input = ref([] as number[])
const sequence = ref([] as number[])

const shadow_block = ref(false)
const good = ref(false)


function gen(length: number) {
  const res = new Set<number>()

  while (res.size != length)
    res.add(Math.floor(Math.random() * (size.value - 1)) + 1)

  return Array.from(res)
}

function nextStep(button?: number) {
  if (shadow_block.value)
    return

  if (!started.value) {
    started.value = true
    sequence.value = gen(round.value + 3)
    return
  }

  if (done.value) {
    user_input.value = []
    done.value = false
    started.value = false
    round.value = 1
    return
  }

  const index = sequence.value.indexOf(button!)

  if (index == -1)
    return

  if (index != user_input.value.length) {
    shadow_block.value = true
    show_result.value = true

    setTimeout(() => {
      show_result.value = false
      shadow_block.value = false
      done.value = true
    }, 1000)

    return
  }

  user_input.value.push(button!)

  if (user_input.value.length == sequence.value.length) {
    round.value++
    sequence.value = []
    user_input.value = []
    good.value = true
    setTimeout(() => {
      sequence.value = gen(round.value + 3)
      good.value = false
    }, 500)
  }
}


function pos(i: number, j: number) {
  return 5 * (j - 1) + (i - 1) + 1
}

const show_result = ref(false)
const hint = computed(() => show_result.value || round.value == 1 || user_input.value.length == 0)

</script>

<template>


  <div :class="{'bg-orange-400': good, 'bg-secondary': !good && !show_result, 'bg-red-600': show_result}"
       class="rounded-t-2xl p-1 flex flex-col justify-center text-white
          items-center elevation-2 h-full gap-4 relative">
    <template v-if="!started">
      <svg class="pulse-faint hero-icon" color="white" fill="none" height="128" viewBox="0 0 128 128" width="128" xmlns="http://www.w3.org/2000/svg">
        <rect fill="currentcolor" height="58" rx="10" width="58"></rect>
        <rect fill="currentcolor" height="58" rx="10" width="58" x="70"></rect>
        <rect fill="currentcolor" height="58" rx="10" width="58" y="70"></rect>
        <path clip-rule="evenodd"
              d="M118 80H80L80 118H118V80ZM80 70C74.4772 70 70 74.4772 70 80V118C70 123.523 74.4772 128 80 128H118C123.523 128 128 123.523 128 118V80C128 74.4772 123.523 70 118 70H80Z"
              fill="currentcolor"
              fill-rule="evenodd"></path>
      </svg>
      <h3 class="text-2xl text-center relative mb-4">
        {{ gameNames['chimp_test'] }}
      </h3>

      <h4 class="text-xl p-2 text-center">
        Êtes-vous plus malin qu'un chimpanzé ? <br>
        <span class="text-sm">Cliquez sur les chiffres dans l'ordre croissant.</span>
      </h4>

      <div class="mt-4">
        <v-btn class="w-full" color="primary" @click="nextStep">
          Commencer
        </v-btn>
      </div>
    </template>
    <template v-else-if="!done">
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full relative mt-8">

        <div class="text-xl text-white px-4 text-center w-full absolute -top-6 left-0">
          round: {{ round }}
        </div>

        <div class="flex flex-row justify-center items-center gap-2 w-full px-4">
          <div v-for="i in 5" :key="i" class="flex flex-col w-full flex-1 gap-2">
            <v-responsive v-for="j in 8" :key="j"
                          :class="{ 'opacity-0': !sequence.includes(pos(i, j)) || user_input.includes(pos(i, j)), 'bg-white': !hint }"
                          aspect-ratio="1" class="rounded-lg border-white border-4 flex justify-center items-center"
                          @pointerdown="nextStep(pos(i, j))"
            >
              <div v-show="hint" class="text-center" v-text="sequence.indexOf(pos(i, j)) + 1"/>
            </v-responsive>
          </div>
        </div>


      </div>
    </template>
    <template v-else>
      <!--      done, show score and restart -->
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full">

        <div class="text-3xl text-white px-4 text-center items-center
                flex flex-col mb-6">
          Votre score: {{ round }}
        </div>

        <div class="text-lg text-white px-4 text-center items-center
                flex flex-col mb-6">
          Votre score a été enregistré.
        </div>

        <div class="flex gap-4 w-full justify-center">
          <v-btn color="primary" @click="nextStep()">
            Recommencer
          </v-btn>
        </div>


      </div>
    </template>
  </div>
</template>

