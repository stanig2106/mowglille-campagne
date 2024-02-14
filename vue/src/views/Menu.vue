<script lang="ts" setup>

import {Carousel, Slide} from 'vue3-carousel'
import FlipCard from "@/views/menu_/FlipCard.vue";
import {useCurrentEventStore} from "@/stores/current_event_store";

import 'vue3-carousel/dist/carousel.css'

const currentEventStore = useCurrentEventStore()
currentEventStore.updateCurrentEvent()


</script>

<template>
  <div class="bg-white rounded-t-2xl py-4 flex flex-col elevation-2 min-h-full relative">
    <Carousel :itemsToShow="1.50" wrap-around :transition="300">
      <Slide v-for="menu in currentEventStore.current_event?.menu" :key="menu.id">
        <flip-card class="carousel__slide">
          <template #front>
            <div class="w-full h-full bg-white flex flex-col p-4">
              <v-img :src="'menu/' + menu.src" class="flex-1 mb-2" :transition="false"/>
              <div>
                {{ menu.name }}
              </div>
              <div class="text-green-600">
                {{ menu.vg ? "Végétarien" : "" }}
              </div>
            </div>
          </template>
          <template #back>
            <div class="w-full h-full bg-white fles flex-center p-2">
              On rajoute des trucs ici
            </div>
          </template>
        </flip-card>
      </Slide>

      ...
    </Carousel>
  </div>
</template>

<style lang="scss">
.carousel__slide {
  padding: 5px;
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
