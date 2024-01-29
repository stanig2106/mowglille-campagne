<script lang="ts" setup>

import Galerie from "@/components/Galerie.vue";

import fake_pp from "@/assets/fake/profile.jpeg"


</script>

<template>
  <v-card>
    <v-card-title>
      <h2 class="text-2xl text-center mt-4">
        Soutenez Mowg'Lille !
      </h2>
    </v-card-title>
    <v-card-text>
      <h3 class="text-lg">
        Télécharger votre photo avec notre filtre soutient actif et
        gagnez 10% de miel en plus si vous l'utiliser sur facebook !
      </h3>


      <galerie :images="[{
        thumbnailURL: fake_pp,
        largeURL: fake_pp,
        width: 1080,
        height: 1080
      }]" gallery-id="soutient-actif-galery"/>


      <div class="flex justify-center gap-2 mt-4">
        <v-btn class="w-1/2" color="primary" @click="() => $router.push('/profile')">
          <v-icon>mdi-download</v-icon>
          Télécharger
        </v-btn>
      </div>
    </v-card-text>
  </v-card>
</template>

