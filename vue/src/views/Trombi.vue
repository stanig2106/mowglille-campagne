<script lang="ts" setup>

import photo_de_liste from "@/assets/trombi/photo_de_liste.webp";
import Galerie from "@/components/Galerie.vue";
import {ref} from "vue";

async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const photo_de_liste_size = ref(null as { width: number, height: number } | null);
getImagesSize(photo_de_liste).then(size => photo_de_liste_size.value = size);

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <div>
      <h3>
        Photo de liste
      </h3>
      <galerie :images="[{
       thumbnailURL: photo_de_liste,
       ...photo_de_liste_size
     }]" v-if="photo_de_liste_size" class="rounded-lg overflow-hidden mt-2"/>
    </div>

    <div>
      <h3>
        Petit bureau
      </h3>
    </div>
  </div>
</template>
