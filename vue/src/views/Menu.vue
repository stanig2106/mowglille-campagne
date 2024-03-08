<script lang="ts" setup>

import {Carousel, Slide} from 'vue3-carousel'
import FlipCard from "@/views/menu_/FlipCard.vue";
import {useCurrentEventStore} from "@/stores/current_event_store";

import 'vue3-carousel/dist/carousel.css'

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()


</script>

<template>
  <div class="rounded-t-2xl py-4 flex flex-col justify-center min-h-full relative gap-12 pt-16">
    <Carousel :itemsToShow="1.50" :transition="300" wrap-around>
      <Slide v-for="menu in currentEventStore.current_event?.menu" :key="menu.id">
        <flip-card class="carousel__slide">
          <template #front>
            <div class="w-full h-full bg-white flex flex-col p-4">
              <v-img :src="'menu/' + menu.src" :transition="false" class="flex-1 mb-2"/>
              <div>
                {{ menu.name }}
              </div>
              <div class="text-green-600">
                {{ menu.vg ? "Végétarien" : "" }}
              </div>
              <div class="text-purple-600" v-if="menu.type == 'CLA'">
                Classique du chef
              </div>
            </div>
          </template>
          <template #back>
            <div class="w-full h-full bg-white fles flex-center p-2">
              {{ menu.description }}
            </div>
          </template>
        </flip-card>
      </Slide>
    </Carousel>

    <div class="rounded-t-2xl p-4 flex flex-col bg-white elevation-2 flex-1 -mb-4 relative text-lg gap-2">
      <template v-if="currentEventStore.current_event?.internalId == '2'">
        <h3>
          Ça y est ! Nous y est !
        </h3>
        <div class="mt-2">
          Bienvenue chez les Mowgus, on espère que vous êtes chauds pour des campagnes qui s'annoncent mémorable.
        </div>
        <div>
          Pour le goûter on vous a prévu des crêpes et des gaufres, qu'on peut vous servir avec du sucre, du nutella ou encore de la confiture de fraise ou
          d'abricot.
        </div>
        <div>
          Des sirops à l'eau, goûts <span class="text-purple-800">Myrtille</span> et <span class="text-yellow-600">Banane</span>, seront également dispos en
          quantité très limité !!
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '3'">
        <div>
          Askip il y a une surprise vers minuit <br>
          Surveillez votre téléphone 😉
        </div>
      </template>
      <template v-if="currentEventStore.current_event?.internalId == '4'">
        <div>
          Régalade au programme pour ces premières hotlines.
        </div>
        <div>
          Soyez gourmands et choisissez parmi les croque-monsieur, fajitas ou pizzas.
        </div>
        <div>
          Pour le dessert vous avez le choix entre des crêpes au chocolat, des cookies et du gâteau à l'orange.
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '8'">
        <div>
          Pour ce déjeuner rejoignez les Mowgus et venez déguster :
        </div>
        <div>
          - Pan Con Tomate en entrée
        </div>
        <div>
          - Croque Monsieur ou Lasagnes Végétarienne en plat
        </div>
        <div>
          - Brownie en dessert
        </div>
        <div>
          Des sirops à l'eau, goûts
          <span class="text-purple-800">Myrtille</span> et <span class="text-brown-lighten-1">Kiwi-Banane</span>,
          seront également dispos en quantité très limité !!
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '6'">
        <div>
          Premier Petit Dej dans la Mowgance ! Si vous aussi vous en avez déja marre des crêpes alors vous allez être servi.
        </div>
        <div>
          Aujourd'hui au menu :
        </div>
        <div>
          Panini Tomate Mozzarella
        </div>
        <div>
          Gâteau au Yaourt à déguster avec du Nutella, de la confiture ou bien nature
        </div>
        <div>
          Cookies
        </div>
        <div>
          Pancakes à accompagner de Nutella, de sirop d'érable ou de confiture
        </div>
        <div>
          Gaufres qui peuvent être mangées avec du Nutella, du sucre ou de la confiture
        </div>
        <div>
          Café et chocolat chaud seront également disponibles.
        </div>
      </template>


      <template v-if="currentEventStore.current_event?.internalId == '5'">
        <h3>
          Bienvenue au premier Dej des Mowgus !
        </h3>
        <div class="mt-2">
          Aujourd'hui c'est tout feu tout flam's, n'hésitez pas à aller voir les staffeurs si vous voulez du Fuze Tea ou des sirops
          <span class="text-purple-800">Myrtille</span> et <span class="text-yellow-600">Pêche</span>.
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '9'">
        <h3>
          Pour cette fin d'aprem, on fait dans la gourmandise !
        </h3>
        <div>
          Roulé Saucisse
        </div>
        <div>
          Burger au Tenders et Frites
        </div>
        <div>
          Gâteau au Yaourt à manger avec du Nutella ou Nature
        </div>
        <div>
          Des Crêpes à déguster avec du Nutella ou du Sucre
        </div>
        <div>
          Au niveau des boissons, on vous propose chocolat chaud, chocolat chaud Baileys et bien sûr notre classique Fuze Tea
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '10'">
        <h3>
          Lesssgui pour les Dark Hotlines ! <br>
          Au choix ce soir :
        </h3>
        <div>
          Croque-Monsieur
        </div>
        <div>
          Tarte à la tomate
        </div>
        <div>
          Pizzas Diavola et Margarita
        </div>
        <div>
          Cookies
        </div>
        <div>
          Crêpes au chocolat
        </div>
        <div>
          Fondant au Chocolat
        </div>
        <div>
          Sandwich Salade du chef (uniquement sur la Rez, appeler le 0695869173)
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '11'">
        <h3>
          Dernier petit déjeuner proposé par les Mowgus aujourd'hui !
        </h3>
        <div>
          Au menu :
        </div>
        <div>
          Avocado Toast
        </div>
        <div>
          Pancakes à déguster avec du Nutella ou du sirop d'érable
        </div>
        <div>
          Tarte aux Pommes et Tartes Pomme/Cannelle
        </div>
        <div>
          Crêpes à manger avec du Nutella, du sucre ou de la confiture
        </div>
        <div class="mt-2">
          Au niveau des boissons on vous propose café, chocolat chaud et notre traditionnel Fuze Tea
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '13'">
        <h3>
          Pour notre Aprèm, Aubin vous propose :
        </h3>
        <div>
          Briques végétariennes
        </div>
        <div>
          Tartes Soleil Tomate Pesto
        </div>
        <div>
          Crêpes et Gaufres accompagnées de leur traditionnels Nutella et sucre
        </div>

        <div class="mt-2">
          Vous pourrez également retrouver du chocolat chaud et des jus de fruits
        </div>
      </template>

      <template v-if="currentEventStore.current_event?.internalId == '14'">
        <div>
          Pour notre 20h/00h, l'admin n'a pas voulu qu'on ramène une broche mais c'est pas ça qui va nous empêcher de vous régaler.
        </div>
        <div class="italic">
          Dédicace à Triolo Food
        </div>
        <div>
          Pour notre dernier event venez au foyer déguster un bon grec frites et un bon cookie en dessert.
        </div>
      </template>


    </div>
  </div>
</template>

<style lang="scss">
.carousel__slide {
  padding: 5px;
  transform: unset;
}

.carousel__viewport {
  padding-top: 10px;
  padding-bottom: 30px;
  perspective: 2000px;
}

.carousel__track {
  transform-style: preserve-3d;
}

.carousel__slide--sliding {
  transition: 0.5s;
}

.carousel__slide {
  opacity: 0.9;
  transform: rotateY(-20deg) scale(0.9);
}

.carousel__slide--active ~ .carousel__slide {
  transform: rotateY(20deg) scale(0.9);
}

.carousel__slide--prev {
  opacity: 1;
  transform: rotateY(-10deg) scale(0.95);
}

.carousel__slide--next {
  opacity: 1;
  transform: rotateY(10deg) scale(0.95);
}

.carousel__slide--active {
  opacity: 1;
  transform: rotateY(0) scale(1.1) translateZ(100px) translateX(2%);
}
</style>
