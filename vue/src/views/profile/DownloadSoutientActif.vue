<script lang="ts" setup>


import overlay from "@/assets/fake/overlay_soutien_actif.png";

import {fabric} from "fabric";
import {onMounted, onUnmounted, ref, watch} from "vue";

const props = defineProps<{
  pp: string | null
}>();

let download = () => {
}

let canvas = undefined as fabric.Canvas | undefined;

onMounted(() => {
  if (props.pp == null) return;

  canvas = new fabric.Canvas(document.getElementById('soutien_preview') as HTMLCanvasElement, {
    containerClass: '!w-full !h-full',
    selection: false,
  });

  // canvas.setBackgroundImage() TODO: ARTHUR

  fabric.Image.fromURL(props.pp, (img) => {
    img?.set({
      originX: 'left',
      originY: 'top',
      left: 0,
      top: 0,
      height: img.height,
      width: img.width,
      scaleX: canvas!.width! / img.width!,
      scaleY: canvas!.height! / img.height!,
      hasBorders: false,
      hasControls: false,
    });
    canvas?.insertAt(img, 0, false);

    watch(size, (new_size) => {
      if (!img || !canvas) return;
      img?.set({
        scaleX: canvas!.width! / img.width! * new_size / 100,
        scaleY: canvas!.height! / img.height! * new_size / 100,
      });
      canvas!.renderAll();
    })

    download = () => {
      // Obtenir l'URL de données du canvas
      const dataURL = canvas!.getElement().toDataURL('image/png');

      // Convertir l'URL de données en Blob
      const xhr = new XMLHttpRequest();
      xhr.open('GET', dataURL, true);
      xhr.responseType = 'blob';
      xhr.onload = function (e) {
        if (this.status == 200) {
          // Créer un lien pour le téléchargement
          const blob = this.response;
          const downloadLink = document.createElement('a');
          downloadLink.href = window.URL.createObjectURL(blob);
          downloadLink.download = 'soutien_actif_mowglille.png';
          downloadLink.click();
        }
      };
      xhr.send();
    }
  });

  const imageOverlay = new Image();
  imageOverlay.src = overlay;
  imageOverlay.onload = () => {
    canvas?.setOverlayImage(imageOverlay.src, canvas!.renderAll.bind(canvas!), {
      originX: 'left',
      originY: 'top',
      left: 0,
      top: 0,
      height: imageOverlay.height,
      width: imageOverlay.width,
      scaleX: canvas!.width! / imageOverlay.width,
      scaleY: canvas!.height! / imageOverlay.height,
    });
  }
})

onUnmounted(() => {
  canvas?.dispose();
  canvas = undefined;
})

const size = ref(100);

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

      <template v-if="pp != null">
        <div class="w-full aspect-square mt-4">
          <canvas id="soutien_preview" class="!w-full !h-full border border-black"
                  height="1024" width="1024"/>
        </div>

        <v-slider v-model="size" class="mt-2" max="250" min="30"/>

        <div class="flex justify-center gap-2 mt-4">
          <v-btn class="w-1/2" color="primary" @click="() => download()">
            <v-icon>mdi-download</v-icon>
            Télécharger
          </v-btn>
        </div>
      </template>

      <template v-else>
        <div class="text-lg mt-4">
          Commencez d'abord par ajouter une photo de profil !
        </div>

        <div class="flex justify-center gap-2 mt-4 mb-2">
          <v-btn color="primary">
            <v-icon>mdi-account</v-icon>
            Ajouter une photo de profil
          </v-btn>
        </div>
      </template>
    </v-card-text>
  </v-card>
</template>

