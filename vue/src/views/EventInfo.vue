<script lang="ts" setup>

import {useCurrentEventStore} from "@/stores/current_event_store";
import {ref} from "vue";
import planning from "@/assets/planning.webp";
import Galerie from "@/components/Galerie.vue";
import affiche_torcho from "@/assets/com/affiche_torcho.webp";
import affiche_hotline from "@/assets/com/affiche_hotline.webp";
import affiche_dej1 from "@/assets/com/affiche_dej1.webp";

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()

async function getImagesSize(path: string) {
  const image = new Image();
  image.src = path;
  await new Promise((resolve) => image.onload = resolve);
  return {width: image.width, height: image.height};
}

const planning_size = ref(null as { width: number, height: number } | null);
getImagesSize(planning).then(size => planning_size.value = size);

const affiche_torcho_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_torcho).then(size => affiche_torcho_size.value = size);

const affiche_hotline_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_hotline).then(size => affiche_hotline_size.value = size);

const affiche_dej1_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_dej1).then(size => affiche_dej1_size.value = size);

</script>

<template>
  <div class="bg-white rounded-t-2xl p-4 flex flex-col elevation-2 min-h-full relative gap-6">
    <template v-if="currentEventStore.current_event?.internalId == '2'">
      Salut les 🐻oursons🐻 ! <br><br>

      On vous attend derrière le Foyer de la Rez, au niveau du barbecue. Vous pourrez engloutir nos crêpes🥞 & gaufres🧇 et surtout obtenir quelques goodies🍯 !
      <br> <br>

      Et ce soir, CA VA PETER ! Le Foyer ouvre ses portes à 22h. Les 40 premiers et 40 premières à arriver pourront bénéficier du pack gourmand😋- 1 parfum SPPC,
      1 paquet de Hollywood Chewing-gum et 2 préservatifs Skyn !

      <galerie v-if="planning_size" :images="[{
        thumbnailURL: planning,
        ...planning_size
      }]" class="rounded-lg overflow-hidden mt-2"/>
    </template>

    <template v-if="currentEventStore.current_event?.internalId == '3'">
      Ce soir, CA VA PETER ! Le Foyer ouvre ses portes à 22h. Les 40 premiers et 40 premières à arriver pourront bénéficier du pack gourmand😋- 1 parfum SPPC,
      1 paquet de Hollywood Chewing-gum et 2 préservatifs Skyn !

      <galerie v-if="affiche_torcho_size" :images="[{
        thumbnailURL: affiche_torcho,
        ...affiche_torcho_size
      }]" class="rounded-lg overflow-hidden mt-2"/>
    </template>

    <template v-if="currentEventStore.current_event?.internalId == '4'">
      [HOTLINES] [MOW’GOURMANDISE] [14h-18h]
      Salut les oursons 🐻,
      A 14h commencent les hotlines, pour lesquelles vos mowgus vous ont préparé plein de délicieuses recettes 🍯
      Au menu, croque-monsieurs🥪, fajitas🥙, pizzas 🍕, gâteau à l’orange🥧, cookies et crêpes 🥞. Un form sera posté à 14h pile pour que vous puissiez commander.
      On vous donne rendez-vous sur notre appli Mowg’Lille pour visionner notre menu!
      Rendez-vous à la rez ou dans Lille, vos mowgus viendront vous livrer avec plaisir 😊
      Soyez à l’affût, la cuisine mowgu est réputée dans les alentours et risque d’être prise d’assauts !😋
      A tout à l’heure pour égayer vos papilles🌟

      <galerie v-if="affiche_torcho_size" :images="[{
        thumbnailURL: affiche_hotline,
        ...affiche_hotline_size
      }]" class="rounded-lg overflow-hidden mt-2"/>
    </template>

    <template v-if="currentEventStore.current_event?.internalId == '5'">
      <h3>
        [Déjeuner] [Tout feu tout flam’s]
      </h3>
      Hello les oursons🐻, <br>
      On espère que vous avez bien dormi ! <br>
      Aujourd’hui, les mowgus vous ont dégoté un partenariat avec Flam’s pour le déjeuner ! 😋 <br>
      Venez vous restaurer à Centrale ou à la rez de 11h30 à 13h30 pour 3€ (ou 2€ pour les petites faims qui ne veulent pas de dessert) <br>
      Au menu, une part de flam’s salée et une part de flam’s sucrée ! 🍕 <br>
      Vos mowgus vous ont aussi préparé quelques jeux et quizz sur les membres de la liste pour vous aider à découvrir les secrets qui se cachent chez les
      Mowg'lille 😉 <br>
      À tout à l’heure ! 🍯

      <galerie v-if="affiche_dej1_size" :images="[{
        thumbnailURL: affiche_dej1,
        ...affiche_dej1_size
      }]" class="rounded-lg" style="overflow: hidden;"/>
    </template>
  </div>


</template>
