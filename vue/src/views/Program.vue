<script lang="ts" setup>

import programme_court from "@/assets/programme/court.webp";
import programme_court_p from "@/assets/programme/court_portrait.webp";
import programme_long from "@/assets/programme/long.webp";
import Galerie from "@/components/Galerie.vue";
import {ref} from "vue";

async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const court_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_court).then(size => court_size.value = size);

const court_p_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_court_p).then(size => court_p_size.value = size);

const long_size = ref(null as { width: number, height: number } | null);
getImagesSize(programme_long).then(size => long_size.value = size);

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <div>
      <h3>
        Programme en quelques mots
      </h3>
      <galerie v-if="court_size && court_p_size" :images="[{
       thumbnailURL: programme_court,
        ...court_size
     }, {
       thumbnailURL: programme_court_p,
       ...court_p_size
     }]" class="rounded-lg overflow-hidden mt-2"/>
    </div>

    <div>
      <h3>
        Version longue :
      </h3>
      <div class="mt-2">
        La terrible jungle nous empêche de vous en dire plus pour le moment.
        Mais restez connectés, on vous en dira plus très bientôt.
      </div>

    </div>
  </div>
</template>
