<script lang="ts" setup>


import overlay from "@/assets/overlay/fg_collector.webp";
import bg_overlay from "@/assets/overlay/bg_collector.webp";


import {fabric} from "fabric";
import {onMounted, onUnmounted, ref, watch} from "vue";


const props = defineProps<{
  pp: string | null
  pp_bg: string | null
}>();

let download = () => {
}

let canvas = undefined as fabric.Canvas | undefined;


onMounted(async () => {
    if (props.pp == null) return;

    canvas = new fabric.Canvas(document.getElementById('soutien_preview') as HTMLCanvasElement, {
      containerClass: '!w-full !h-full',
      selection: false,
    });

    const bg_overlay_image = new Image();
    bg_overlay_image.src = bg_overlay;

    canvas.setBackgroundImage(bg_overlay, canvas.renderAll.bind(canvas), {
      originX: 'left',
      originY: 'top',
      left: 0,
      top: 0,
      height: canvas.height!,
      width: canvas.width!,
      scaleX: canvas.width! / bg_overlay_image.width,
      scaleY: canvas.height! / bg_overlay_image.height,
    });

    await new Promise<void>((r) => {
      fabric.Image.fromURL(bg_overlay, (img) => {
        img?.set({
          visible: !remove_bg.value,
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
          lockMovementX: true,
          lockMovementY: true,
          selectable: false,
        });
        canvas?.insertAt(img, 0, false);


        r()
      }, {crossOrigin: 'anonymous'});
    })

    await new Promise<void>((r) => {
      fabric.Image.fromURL(props.pp!, (img) => {
        img?.set({
          visible: !remove_bg.value,
          originX: 'left',
          originY: 'top',
          left: 0,
          top: 0,
          height: img.height,
          width: img.width,
          scaleX: canvas!.width! / Math.min(img.width!, img.height!),
          scaleY: canvas!.height! / Math.min(img.width!, img.height!),
          hasBorders: false,
          hasControls: false,
        });
        canvas?.insertAt(img, 1, false);

        watch(size, (new_size) => {
          if (!img || !canvas) return;
          img?.set({
            scaleX: canvas!.width! / Math.min(img.width!, img.height!) * new_size / 100,
            scaleY: canvas!.height! / Math.min(img.width!, img.height!) * new_size / 100,
          });
          canvas!.renderAll();
        })

        watch(remove_bg, async (new_remove_bg) => {
          if (!img || !canvas) return;
          img?.set({
            visible: !new_remove_bg,
            lockMovementX: new_remove_bg,
            lockMovementY: new_remove_bg,
          });
          canvas!.renderAll();
        })

        r()
      }, {crossOrigin: 'anonymous'});
    })

    if (props.pp_bg != null)
      await new Promise<void>(async (r) => {
        fabric.Image.fromURL(props.pp_bg!, (img) => {
          img?.set({
            visible: remove_bg.value,
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
          canvas?.insertAt(img, 2, false);

          watch(size, (new_size) => {
            if (!img || !canvas) return;
            img?.set({
              scaleX: canvas!.width! / img.width! * new_size / 100,
              scaleY: canvas!.height! / img.height! * new_size / 100,
            });
            canvas!.renderAll();
          })

          watch(remove_bg, async (new_remove_bg) => {
            if (!img || !canvas) return;
            img?.set({
              visible: new_remove_bg,
              lockMovementX: !new_remove_bg,
              lockMovementY: !new_remove_bg,
            });
            canvas!.renderAll();
          })

          r()
        }, {crossOrigin: 'anonymous'});
      })


    download = () => {
      // Obtenir l'URL de données du canvas
      const dataURL = canvas!.getElement().toDataURL('image/png');

      // Convertir l'URL de données en Blob
      const xhr = new XMLHttpRequest();
      xhr.open('GET', dataURL, true);
      xhr.responseType = 'blob';
      xhr.onload = function () {
        if (this.status == 200) {
          // Créer un lien pour le téléchargement
          const blob = this.response;
          const downloadLink = document.createElement('a');
          downloadLink.href = window.URL.createObjectURL(blob);
          downloadLink.download = 'soutien_actif_mowglille.png';

          if (navigator.userAgent.toLowerCase().indexOf('iphone') > -1 || navigator.userAgent.toLowerCase().indexOf('safari') > -1)
            alert("Sur iOS, appuyez longuement sur l'image et sélectionnez 'Enregistrer l'image'")

          downloadLink.click();
        }
      }

      xhr.send();
    }


    console.log("overlay")
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
  }
)

onUnmounted(() => {
  canvas?.dispose();
  canvas = undefined;
})

const size = ref(100);
const remove_bg = ref(false);

watch(remove_bg, () => {
  size.value = 100;
})

const emit = defineEmits<{
  cancel: []
  download: []
  add_photo: []
}>()


</script>

<template>
  <v-card>
    <v-card-title>
      <h2 class="text-2xl text-center mt-2">
        Soutenez Mowg'Lille !
      </h2>
    </v-card-title>
    <v-card-text>
      <h3 class="text-lg -mt-4">
        Télécharger votre photo avec notre filtre soutient actif et
        gagnez 10% de miel en plus si vous l'utiliser sur facebook !
      </h3>

      <!--      <v-switch v-model="remove_bg"-->
      <!--                :disabled="pp_bg == null"-->
      <!--                color="secondary" hide-details-->
      <!--                label="Supprimer le fond"/>-->

      <template v-if="pp != null">
        <div class="w-full aspect-square mt-2">
          <canvas id="soutien_preview" class="!w-full !h-full border border-black"
                  height="1024" width="1024"/>
        </div>

        <v-slider v-model="size" class="mt-2" max="250" min="30"/>

        <div class="flex justify-between gap-2 mt-4">
          <v-btn variant="text" @click="emit('cancel')">
            Annuler
          </v-btn>

          <v-btn color="secondary" variant="text"
                 @click="() => {download(); emit('download')}">
            <v-icon>mdi-download</v-icon>
            Télécharger
          </v-btn>
        </div>
      </template>

      <template v-else>
        <div class="text-lg mt-4">
          Commencez d'abord par ajouter une photo de profil !
        </div>

        <div class="flex justify-end gap-2 mt-4 mb-2">
          <v-btn color="secondary" variant="text" @click="emit('add_photo')">
            Ajouter une photo de profil
          </v-btn>
        </div>
      </template>
    </v-card-text>
  </v-card>
</template>

