<script lang="ts" setup>

import {ref} from "vue";
import {gameNames} from "./humanBenchmark";
import {saveScore} from "@/views/games/Score";

const started = ref(false);
const done = ref(false)

const round = ref(1)
const size = ref(3)

const user_input = ref([] as number[])
const sequence = ref([] as number[])
const show = ref(false)
const shadow_block = ref(false)
const missed = ref([] as number[])
const dead = ref(false)

async function showSequence() {
  show.value = true
  await new Promise(resolve => setTimeout(resolve, 1000))
  show.value = false
  shadow_block.value = false
}


function gen(size: number, length: number) {
  size *= size
  const res = new Set<number>()

  while (res.size != length)
    res.add(Math.floor(Math.random() * (size - 1)) + 1)

  return Array.from(res)
}

function nextStep(button?: number) {
  if (!started.value) {
    started.value = true
    sequence.value = gen(size.value, round.value + 2)
    shadow_block.value = true
    setTimeout(showSequence, 500)
    return
  }

  if (done.value) {
    missed.value = []
    dead.value = false
    user_input.value = []
    done.value = false
    started.value = false
    round.value = 1
    size.value = 3
    return
  }


  if (user_input.value.includes(button!) || missed.value.includes(button!))
    return

  if (sequence.value.includes(button!)) {
    user_input.value.push(button!)
    if (user_input.value.length == sequence.value.length) {
      shadow_block.value = true
      setTimeout(() => {
        round.value++
        if (should_increase(round.value))
          size.value++
        user_input.value = []
        missed.value = []
        sequence.value = gen(size.value, round.value + 2)
        setTimeout(showSequence, 500)
      }, 500)
    }
    return
  }

  missed.value.push(button!)
  if (missed.value.length == 3) {
    shadow_block.value = true
    dead.value = true

    setTimeout(() => done.value = true, 1000)

    saveScore('human_benchmark_visual_memory', round.value - 1,
      {
        title: "Score de " + gameNames['visual_memory'],
        message: "Round: " + (round.value - 1)
      })
  }

}


function should_increase(n: number) {
  if (n < 10)
    return n % 3 == 0
  if (n < 30)
    return n % 4 == 0
  return n % 7 == 3
}

function pos(i: number, j: number) {
  return size.value * (j - 1) + (i - 1) + 1
}


</script>

<template>


  <div :class="{'!bg-orange-400': show, 'bg-secondary': !show, '!p-1': size >= 6}" class="rounded-t-2xl p-4 flex flex-col justify-center text-white
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
        {{ gameNames['visual_memory'] }}
      </h3>

      <h4 class="text-xl p-2 text-center">
        Mémorisez les paternes et reproduisez les.
      </h4>

      <div class="mt-4">
        <v-btn class="w-full" color="primary" @click="nextStep">
          Commencer
        </v-btn>
      </div>
    </template>
    <template v-else-if="!done">
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full relative">

        <div class="text-xl text-white px-4 text-center w-full absolute top-0 left-0">
          round: {{ round }}
        </div>

        <div class="w-full">
          <div :class="{'!gap-1': size >= 6}" class="flex flex-row justify-center items-center gap-2">
            <div v-for="i in size" :key="i" :class="{'!gap-1': size >= 6}" class="flex flex-col w-full flex-1 gap-2">
              <v-responsive v-for="j in size" :key="j"
                            :class="{ '!bg-white !opacity-100': user_input.includes(pos(i, j)) || show && sequence.includes(pos(i, j)),
                            '!bg-gray-600 !opacity-70': missed.includes(pos(i, j)) && !dead,
                             '!bg-red-800 !opacity-70': dead && sequence.includes(pos(i, j)) && !user_input.includes(pos(i, j)) }"
                            aspect-ratio="1" class="rounded-lg bg-gray-300 opacity-40 flex justify-center items-center"
                            @pointerdown="!show && !shadow_block && nextStep(pos(i, j))"
              />
            </div>
          </div>

        </div>

      </div>
    </template>
    <template v-else>
      <!--      done, show score and restart -->
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full">

        <div class="text-3xl text-white px-4 text-center items-center
                flex flex-col mb-6">
          Votre score: {{ round - 1 }}
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

