<script lang="ts" setup>

import programme_court_p from "@/assets/programme/court_portrait.webp";
import programme_long from "@/assets/programme/long.webp";
import programme_long2 from "@/assets/programme/long2.webp";
import Galerie from "@/components/Galerie.vue";
import {ref} from "vue";

async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const court_p_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_court_p).then(size => court_p_size.value = size);

const long_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_long).then(size => long_size.value = size);
const long2_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_long2).then(size => long2_size.value = size);

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <div>
      <h3>
        Programme en quelques mots
      </h3>
      <galerie v-if="court_p_size" :images="[{
       thumbnailURL: programme_court_p,
        ...court_p_size
     }]" class="rounded-lg overflow-hidden mt-2"/>
    </div>

    <div>
      <h3>
        Version longue :
      </h3>
      <galerie v-if="court_p_size" :images="[{
       thumbnailURL: programme_long,
        ...long_size
         }, {
        thumbnailURL: programme_long2,
        ...long2_size
       }]" class="rounded-lg overflow-hidden mt-2"/>
    </div>
  </div>
</template>
