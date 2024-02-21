<script lang="ts" setup>
import honey from "@/assets/honey.webp";
import {computed} from "vue";

const props = defineProps<{
  title: string,
  subtitle: string,
  score: number,
  event: string,
  hour: string
}>()


</script>

<template>
  <div class="flex justify-between w-full h-full items-center px-4">
    <div class="flex gap-2 items-center">
      <div class="flex flex-col justify-center">
        <h1 class="text-lg">
          {{ title }}
        </h1>
        <div class="text-md text-gray-500 pr-2">
          {{ subtitle }}
        </div>
      </div>
    </div>

    <div class="flex flex-col gap-1">
      <div class="bg-gray-400 bg-opacity-40 rounded-lg p-2 flex justify-end gap-2">
        <h1 class="text-xl">
          {{ score >= 0 ? ("+" + score) : score }}
        </h1>
        <v-img :src="honey" :transition="false" class="h-6 w-6"/>
      </div>
      <div class="text-sm text-gray-500 flex justify-end text-end">
        {{ event }}, {{ hour }}
      </div>
    </div>
  </div>
</template>
