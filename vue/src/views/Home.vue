<script lang="ts" setup>
import logo_text from "@/assets/logo_text.webp";
import prgm from "@/assets/programme/court.webp";
import photo from "@/assets/trombi/photo_de_liste.webp"
import Galerie from "@/views/Galerie.vue";
import {ref} from "vue";
import app_store from "@/assets/store/app_store.svg";
import play_store from "@/assets/store/play_sotre.webp";


async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const photo_size = ref(null as { width: number, height: number } | null);
getImagesSize(photo).then(size => photo_size.value = size);

const prgm_size = ref(null as { width: number, height: number } | null);
getImagesSize(prgm).then(size => prgm_size.value = size);

function store(type: "app" | "play") {
  window.open(type == "app" ?
    "https://apps.apple.com/fr/app/mowglille/id6475304610" :
    "https://play.google.com/store/apps/details?id=fr.mowglille.twa&hl=fr&gl=FR"
  )
}
function facebook() {
  window.open("https://www.facebook.com/mowglille")
}

</script>

<template>
  <div class="flex flex-col gap-6 h-full overflow-auto items-center justify-start p-8">
    <div class="mb-8">
      <v-img :src="logo_text" class="w-60"/>
    </div>

    <h3 class="font-bold">
      Téléchargez l'app
    </h3>

    <div class="flex justify-center gap-2">
      <v-img v-ripple :src="app_store" class="w-32 ml-2 cursor-pointer" @click="store('app')"/>
      <v-img v-ripple :src="play_store" class="ml-8 w-[138px] cursor-pointer" @click="store('play')"/>
    </div>


    <galerie v-if="photo_size" :images="[{
      thumbnailURL: photo,
      ...photo_size
    }]" class="rounded-lg overflow-hidden w-3/4 mt-4"/>

    <galerie v-if="prgm_size" :images="[{
      thumbnailURL: prgm,
      ...prgm_size
    }]" class="rounded-lg overflow-hidden w-3/4 mt-4"/>


    <div class="flex justify-end w-full mt-8">
      © 2024 Mowg'Lille - Tous droits réservés
      <v-spacer/>
      <v-btn variant="text" @click="() => facebook()">Contact</v-btn>
      <v-btn variant="text" @click="() => $router.push('/legal')">Mentions légales</v-btn>
      <v-btn variant="text" @click="() => $router.push('/privacy')">Politique de confidentialité</v-btn>
    </div>
  </div>
</template>

<style>
body {
  background-color: #ffe135;
}
</style>

