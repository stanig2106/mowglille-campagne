<script lang="ts" setup>

import {ref} from 'vue'

const active = ref(false)

</script>

<template>

  <div class="flip-card" @click="active = !active" :class="{ active }">
    <div class="flip-card-inner elevation-2" v-ripple>
      <div class="flip-card-front">
        <slot name="front"/>
      </div>
      <div class="flip-card-back">
        <slot name="back"/>
      </div>
    </div>
  </div>

</template>

<style lang="scss">
.flip-card {
  background-color: transparent;
  width: 300px;
  height: 300px;
  perspective: 1000px;
}

.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transition: transform 0.6s;
  transform-style: preserve-3d;
}

.flip-card.active .flip-card-inner {
  transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}


.flip-card-back {
  transform: rotateY(180deg);
}
</style>
