<script lang="ts" setup>

// v-model is image

import {useVModel} from "@vueuse/core";
// @ts-ignore
import PictureInput from "vue-picture-input";

const props = defineProps<{
  modelValue: any
}>();

const emits = defineEmits<{
  "update:modelValue": [any],
  continue: []
}>();

const image = useVModel(props, "modelValue", emits)

</script>

<template>
  <v-card elevation="10" rounded="xl">
    <div class="p-8 pb-2">
      <v-img src="@/assets/logo_text.png" class="w-[45vw] mx-[15vw] -mt-2 mb-6" contain/>

      <div class="mb-2">
        <label for="image" class="text-xl font-extrabold">PHOTO DE PROFILE:</label>
      </div>

      <picture-input
        @change="(i: any) => i.target.files[0] && $emit('update:modelValue', i.target.files[0])"
        width="500"
        height="500"
        margin="16"
        accept="image/jpeg,image/png"
        size="10"
        button-class="btn"
        class="mb-6 mt-2"
        :custom-strings="{
          upload: '<p>Votre appareil ne supporte pas l\'upload de fichier.</p>',
          drag: 'Glissez une image ou <br>Cliquez ici pour sélectionner un fichier',
          tap: 'Touchez ici pour sélectionner une photo <br>de votre galerie',
          change: 'Changer la photo',
          remove: 'Supprimer la photo',
          select: 'Sélectionner une photo',
          selected: '<p>Photo sélectionnée avec succès !</p>',
          fileSize: 'La taille du fichier dépasse la limite',
          fileType: 'Ce type de fichier n\'est pas supporté.',
          aspect: 'Paysage/Portrait'
        }"/>


      <v-btn color="primary" class="w-full" rounded="lg" :disabled="!image" @click="$emit('continue')">
          <span class="font-extrabold text-uppercase text-2xl">
          Continuer
          </span>
      </v-btn>

      <v-btn variant="text" class="w-full text-muted font-bold underline mt-4"
             rounded="lg" @click="image = null; $emit('continue')">
        Peut être plus tard
      </v-btn>
    </div>


  </v-card>
</template>
