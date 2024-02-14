<script lang="ts" setup>

import {onMounted, onUnmounted, ref} from "vue";

const end_time = new Date("2024-02-30T00:00:00.000Z")

const remaining_time = ref("")


function update_remaining_time() {
  const now = new Date()
  const diff = end_time.getTime() - now.getTime()
  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
  const seconds = Math.floor((diff % (1000 * 60)) / 1000)

  remaining_time.value =
    `${days}j ${hours}h ${minutes}m ${seconds}s`
}

let interval: NodeJS.Timeout | null = null
onMounted(() => {
  update_remaining_time()
  setInterval(update_remaining_time, 1000)
})

onUnmounted(() => interval && clearInterval(interval))

</script>

<template>


  <div class="bg-white rounded-t-2xl p-4 flex flex-col
              justify-between elevation-2 h-full gap-4 relative">

    <div class="text-center text-gray-500 text-xl absolute w-full left-0">
      {{ remaining_time }}
    </div>

    <div class="flex flex-col justify-center items-center gap-4 h-full">

      <v-icon color="primary" size="168">
        mdi-lightning-bolt
      </v-icon>

      <h4 class="text-xl p-2 text-center">
        Évaluez vos compétences avec des jeux de réflexion et des tests cognitifs.
      </h4>

      <div class="flex flex-col gap-4 mt-4">
        <v-btn class="w-full" color="primary" @click="$router.push('/games/human_benchmark/play')">
          Jouer
        </v-btn>

        <v-btn class="w-full"
               variant="tonal" @click="$router.push('/games/human_benchmark/classement')">
          Classement
        </v-btn>

<!--        <v-btn class="w-full"-->
<!--               variant="text" @click="$router.push('/games/safari_sprint')">-->
<!--          Safari Sprint ?-->
<!--        </v-btn>-->
      </div>

    </div>
  </div>

</template>

