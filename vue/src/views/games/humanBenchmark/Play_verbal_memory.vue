<script lang="ts" setup>

import {ref} from "vue";
import {gameNames} from "./humanBenchmark";
import {generateVerbalMemorySequence} from "@/views/games/humanBenchmark/verbal_memory";
import {saveScore} from "@/views/games/Score";

const started = ref(false);
const life = ref(3)
const done = ref(false)

let sequence: Generator<{ word: string; new: boolean }, null, void> | null = null
const word = ref("")
const previous_new = ref(true)
const round = ref(0)
const lose = ref(false)

function nextStep(clicked_new?: boolean) {
  if (done.value) {
    done.value = false
    started.value = false
    life.value = 3
    round.value = 0
    return
  }

  if (!started.value) {
    started.value = true

    sequence = generateVerbalMemorySequence()

    const {value} = sequence.next()
    word.value = value!.word
    previous_new.value = value!.new
    console.log(value)

    return
  }

  if (clicked_new != previous_new.value) {
    life.value--
    lose.value = true
    setTimeout(() => {
      lose.value = false
    }, 500)
  } else
    round.value++

  if (life.value <= 0) {
    done.value = true

    saveScore('human_benchmark_verbal_memory', round.value, {
      title: "Score de " + gameNames['verbal_memory'],
      message: "Round: " + round.value
    })

    return
  }

  const {value} = sequence!.next()
  if (!value) {
    done.value = true

    saveScore('human_benchmark_verbal_memory', round.value, {
      title: "Score de " + gameNames['verbal_memory'],
      message: "Round: " + round.value
    })

    return
  }
  word.value = value.word
  previous_new.value = value.new
}

</script>

<template>


  <div class="rounded-t-2xl p-4 flex flex-col justify-center text-white
          items-center elevation-2 h-full gap-4 relative bg-secondary">
    <template v-if="!started">
      <svg class="pulse-faint hero-icon" color="white" fill="none" height="131" viewBox="0 0 100 131" width="100" xmlns="http://www.w3.org/2000/svg">
        <path clip-rule="evenodd"
              d="M100 5C100 2.23857 97.7614 0 95 0H5C2.23858 0 0 2.23858 0 5V126C0 128.761 2.23858 131 5 131H96C98.2091 131 100 129.209 100 127C100 124.791 98.2091 123 96 123H14.5477C11.7863 123 9.54774 120.761 9.54774 118V106C9.54774 103.239 11.7863 101 14.5477 101H95C97.7614 101 100 98.7614 100 96V5ZM75.1237 80C78.2046 80 80.5524 77.2406 80.0592 74.1995L72.1114 25.1995C71.7188 22.7787 69.6283 21 67.1759 21H61.5314C59.8921 21 58.3568 21.8036 57.4227 23.1508L23.4431 72.1507C21.1437 75.4666 23.5168 80 27.5519 80H28.7769C30.4488 80 32.0101 79.1644 32.9374 77.7732L39.8159 67.4536C40.7432 66.0624 42.3045 65.2268 43.9764 65.2268H62.5724C65.082 65.2268 67.2028 67.0871 67.5298 69.5752L68.3284 75.6516C68.6554 78.1397 70.7762 80 73.2858 80H75.1237ZM55.2419 58.4441C51.2439 58.4441 48.8629 53.9845 51.0871 50.6624L55.3569 44.285C57.9299 40.4418 63.8931 41.852 64.4723 46.4405L65.2773 52.818C65.6542 55.8042 63.3265 58.4441 60.3166 58.4441H55.2419Z"
              fill="currentcolor"
              fill-rule="evenodd"></path>
        <rect fill="currentcolor" height="8" rx="4" width="78" x="16" y="108"></rect>
      </svg>
      <h3 class="text-2xl text-center relative mb-4">
        {{ gameNames['verbal_memory'] }}
      </h3>

      <h4 class="text-xl p-2 text-center">
        Mémorisez les mots qui apparaissent à l'écran.
        Si tu as déjà vu un mot pendant le test, clique sur VU. Si c'est un nouveau mot, clique sur NOUVEAU.
      </h4>

      <div class="mt-4">
        <v-btn class="w-full" color="primary" @click="nextStep">
          Commencer
        </v-btn>
      </div>
    </template>
    <template v-else-if="!done">
      <div class="flex flex-col justify-center items-center gap-4 h-full w-full">

        <div class="text-xl text-white px-4 justify-center
                  flex mb-10 >:flex-1 >:w-full w-full">
          <div :class="{'text-red-600': lose}" class="text-center" style="transition-property: color; transition-duration: .2s">
            Vie: {{ life }}
          </div>

          <div class="text-center">
            Round: {{ round }}
          </div>

        </div>

        <div class="flex flex-col gap-4 w-full items-center">
          <div class="text-4xl text-white px-4 text-center items-center
                flex flex-col mb-6">
            {{ word }}
          </div>

          <div class="flex gap-4 justify-center w-3/4 >:flex-1">
            <v-btn color="primary" @click="nextStep(true)">
              NOUVEAU
            </v-btn>

            <v-btn color="primary" @click="nextStep(false)">
              VU
            </v-btn>
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

