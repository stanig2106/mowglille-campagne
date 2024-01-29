<script lang="ts" setup>
import honey from "@/assets/honey.png";
import axios from "axios";
import {useStorage} from "@vueuse/core";

const score = useStorage("score", "-" as string | number)
axios.get("/score").then(({data}) => score.value = data.score)

</script>

<template>
  <div class="bg-white rounded-2xl p-4 flex justify-end gap-2 items-stretch elevation-2">
    <div class="w-full flex flex-col items-stretch justify-between">
      <h4 class="h-1/2 ml-1">
        SCORE :
      </h4>
      <v-btn rounded="lg" density="compact" size="lg" variant="tonal" class="flex justify-between"
             @click="$router.push('/score_details')">
        <template v-slot:prepend>
          <h2 class="text-3xl text-start w-full px-2">
            {{ score }}
          </h2>
        </template>
        <template v-slot:append>
          <v-img :src="honey" class="h-6 w-6 mr-3" :transition="false"/>
        </template>
      </v-btn>
    </div>
    <v-btn icon rounded="lg" density="compact" size="64" variant="tonal"
           @click="$router.push('/scoreboard')">
      <v-icon size="52">
        mdi-format-list-numbered
      </v-icon>
    </v-btn>

    <v-btn icon rounded="lg" density="compact" size="64" variant="tonal"
           @click="$router.push('/qrcode')">
      <v-icon size="52">
        mdi-qrcode
      </v-icon>
    </v-btn>
  </div>
</template>
