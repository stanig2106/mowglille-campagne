<script lang="ts" setup>

import {useCurrentEventStore} from "@/stores/current_event_store";
import {ref} from "vue";
import planning from "@/assets/planning.webp";
import Galerie from "@/components/Galerie.vue";
import affiche_torcho from "@/assets/com/affiche_torcho.webp";
import affiche_hotline from "@/assets/com/affiche_hotline.webp";
import affiche_dej1 from "@/assets/com/affiche_dej1.webp";
import affiche_pdej1 from "@/assets/com/affiche_pdej1.webp";
import affiche_fin_aprem from "@/assets/com/affiche_fin_aprem.webp";
import affiche_dark_hotline from "@/assets/com/affiche_dark_hotline.webp";
import affiche_brunch from "@/assets/com/affiche_brunch.webp";
import affiche_2000 from "@/assets/com/affiche_2000.webp";


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

const affiche_pdej1_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_pdej1).then(size => affiche_pdej1_size.value = size);

const affiche_fin_aprem_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_fin_aprem).then(size => affiche_fin_aprem_size.value = size);

const affiche_dark_hotline_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_dark_hotline).then(size => affiche_dark_hotline_size.value = size);

const affiche_brunch_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_brunch).then(size => affiche_brunch_size.value = size);

const affiche_2000_size = ref(null as { width: number, height: number } | null);
getImagesSize(affiche_2000).then(size => affiche_2000_size.value = size);

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

    <template v-if="currentEventStore.current_event?.internalId == '6'">
      <h3>
        [PETIT-DEJ] [7h30-10h30] [ECOCUPS]
      </h3>
      Hello les nounours🐻, <br> <br>
      On s'est bien régalés avec les Flam’s ce midi et on vous annonce que c’est pas fini! <br>
      Il est maintenant temps de vous donner des forces demain avant les cours à notre petit-dej dans le hall du bat A de la rez ET dans le couloir des amphis
      de Centrale ! On vous attend de 7h30 à 10h30 !😋
      <br>
      Il y en aura pour tous les goûts puisque nous vous proposons du sucré avec nos gaufres🧇, pancakes🥞, cookies🍪, gâteaux au yaourt 🥧 ainsi que du salé avec
      des paninis tomate mozzarella🍅!
      <br>
      Vous pourrez déguster tout ça avec du café☕️, du chocolat chaud🧋ou encore des jus de fruits🧃! N’oubliez pas vos écocups pour les boissons! <br>
      Ce sera également l’occasion pour vous de remporter un maximum de points sur l’appli Mowg’Lille grâce à nos différents jeux🎰 ! <br> <br>
      La bise qui a hâte de cuisiner votre petit-dej!

      <galerie v-if="affiche_dej1_size" :images="[{
        thumbnailURL: affiche_pdej1,
        ...affiche_pdej1_size
      }]" class="rounded-lg" style="overflow: hidden;"/>
    </template>


    <template v-if="currentEventStore.current_event?.internalId == '9'">
      <h3>
        [FIN D’APREM] [IL EN FAUT PEU POUR ETRE HEUREUX] [17h-20h] [SYNTHE]
      </h3> <br>
      Comme le dit si bien notre ami Baloo, il en faut peu pour être heureux! 🥰 <br>
      Et nous à Centrale on a besoin de quoi pour être heureux? Des activités made in Mowg’Lille et d’un bon repas fait maison!!🐻 <br>
      On vous attend nombreux au synthé avec EH autour de nos jeux plus fous les uns que les autres: concours de hula-hoop, blitz d’échecs♟et la quête aux
      balles qui est un jeu en équipes inédit.
      <br>
      Pour le repas, on vous propose des BURGERS TENDERS 🍔🍗 servis avec des frites 🍟 ainsi que des roulés aux saucisses! Pour le dessert, il y aura des crêpes🥞
      et des délicieux cakes banane chocolat 🥧🍌🍫
      <br>
      Au niveau des bières🍻, on vous servira de la kasteel red, de la brigand et du cidre que vous pourrez boire autour d’un coin-coin ou d’un beer-pong! <br>
      Vous pourrez également repartir avec non pas du faux mais bien du vrai miel en pot 🍯 en remportant notre jeu La quête aux balles! <br>
      La bise mielleuse🍯

      <galerie v-if="affiche_fin_aprem_size" :images="[{
        thumbnailURL: affiche_fin_aprem,
        ...affiche_fin_aprem_size
      }]" class="rounded-lg" style="overflow: hidden;"/>
    </template>

    <template v-if="currentEventStore.current_event?.internalId == '10'">
      <h3>
        [Dark Hotlines][Mowgl’Eats][20h-00h]
      </h3> <br>
      Soyez à l’affût, la cuisine Mowgu est réputée dans les alentours et risque d’être prise d’assaut !
      A tout à l’heure pour se régaler et lever son coude 🍻

      <galerie v-if="affiche_dark_hotline_size" :images="[{
        thumbnailURL: affiche_dark_hotline,
        ...affiche_dark_hotline_size
      }]" class="rounded-lg" style="overflow: hidden;"/>
    </template>


    <template v-if="currentEventStore.current_event?.internalId == '12'">
      <h3>
        [Journée des Mowgus][Banger absolu]
      </h3> <br>
      Salut les oursons ! 🐻 <br>
      La fin des campagnes approche et on se retrouve demain pour les clôturer en beauté avec la journée des Mowgus 🍯 D’abord, venez vous remettre de votre torcho lors de notre brunch gueule de boa 🐍 de 11h à 13h au barbecue. Au menu: avocado toasts 🥑, salade de pâtes 🍝 , quesadillas végé 🥔, frites de patate douce 🍠 pour le salé et salade de fruit 🍎 et brioche perdue 🍞 pour le sucré ! Vos Mowgus vous ont préparé plein de stands pour vous amuser et garder un bon souvenir des campagnes !
      <br>
      On enchaînera avec notre après-midi l'ivre de la jungle 📖 jusqu'à 19h sur le synthé qui vous réserve plein de surprises, notamment une activité vertigineuse pour les plus courageux 😮. Venez gagner un maximum de points pour gagner un de nos lots 🎟️ Encore une fois, on est là pour vous régaler avec nos briques et paninis végé 🥖, tartes soleil pesto tomate 🍰, crêpes 🥞, gaufres 🧇 ainsi que du chocolat chaud 🍫 et des jus de fruit 🥤
      <br>
      La bise qui n’a pas encore dévoilé tous ses secrets 💛


      <galerie v-if="affiche_brunch_size" :images="[{
        thumbnailURL: affiche_brunch,
        ...affiche_brunch_size
      }]" class="rounded-lg" style="overflow: hidden;"/>
    </template>

    <template v-if="currentEventStore.current_event?.internalId == '14'">
      <h2>
      [Les campagnes sont mortes ce soir][20h-00h]
      </h2>
      Salut les oursons 🐻 <br>
      Comme vous le savez, ce soir c’est le 20h-00h des mowgus et la fin des campagnes ! 😮 <br>
      Pour l’occasion, on a décidé de vous réserver encore quelques surprises 💛 <br>
      Vous savez que vous pouvez gagner une switch et plein d’autres lots grâce à nos défis et notre tombolas 🎟️ <br>
      Mais ce n’est pas tout, vous pourrez récupérer vos photos Polaroïd du temple perdu du torcho!Enfin, soyez là à 22h pétante, pour notre show ✨ surprise ✨, vous ne serez pas déçus !
      <br>
      Bonne après midi et à tout à l’heure 🐻 <br>

      <galerie v-if="affiche_2000_size" :images="[{
        thumbnailURL: affiche_2000,
        ...affiche_2000_size
      }]" class="rounded-lg overflow-hidden mt-2"/>
    </template>




  </div>


</template>
