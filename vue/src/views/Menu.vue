<script lang="ts" setup>

import {Carousel, Slide} from 'vue3-carousel'

import 'vue3-carousel/dist/carousel.css'


import FlipCard from "@/views/menu_/FlipCard.vue";
</script>

<template>
  <div class="bg-white rounded-t-2xl py-4 flex flex-col elevation-2 min-h-full relative">
    <Carousel :itemsToShow="1.50" :wrapAround="true" :transition="300">
      <Slide v-for="slide in 10" :key="slide">
        <flip-card class="carousel__slide">
          <template #front>
            <div class="bg-white rounded-lg elevation-2 p-2 flex justify-center items-center h-16 w-16">
              <v-icon size="48">
                mdi-trophy
              </v-icon>
            </div>
          </template>
          <template #back>
            <div class="bg-white rounded-lg elevation-2 p-2 flex justify-center items-center h-16 w-16">
              <v-icon size="48">
                mdi-trophy
              </v-icon>
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
  background-color: white;
  opacity: 1;
  transform: rotateY(0) scale(1.1) translateZ(100px) translateX(2%);
}
</style>
