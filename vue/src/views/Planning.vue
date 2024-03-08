<script lang="ts" setup>

import planning from "@/assets/planning.webp"
import Galerie from "@/components/Galerie.vue";
import {ref} from "vue";

async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const planning_size = ref(null as { width: number, height: number } | null);
getImagesSize(planning).then(size => planning_size.value = size);

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col justify-center elevation-2 min-h-full relative gap-6">
      <galerie :images="[{
       thumbnailURL: planning,
       ...planning_size
     }]" v-if="planning_size" class="rounded-lg overflow-hidden mt-2"/>
  </div>
</template>
