<script lang="ts" setup>
  import {ref} from 'vue'

  const active = ref(false)

</script>

<template>

  <v-card
    class="menu-card"
    @click="active = !active">
    <div
      :class="{ active }"
      class="menu-card-inner">
      <div class="menu-card-front">
        <v-img src="https://cdn.vuetifyjs.com/images/cards/cooking.png"/>
      </div>
      <div class="menu-card-back">
        <v-card-title>
          <span class="headline">Dessert</span>
        </v-card-title>
        <v-card-text>
          <p>
            Donut cotton candy gingerbread sweet roll pudding. Chocolate cake sweet roll
            chocolate cake sweet roll pudding.
          </p>
        </v-card-text>
      </div>
    </div>
  </v-card>

</template>

<style lang="scss">
  .menu-card {
    perspective: 1000px;
  }

  .menu-card-inner {
    position: relative;
    transition: transform 0.6s;
    transform-style: preserve-3d;
  }

  .menu-card.active .menu-card-inner {
    transform: rotateY(180deg);
  }

  .menu-card-front, .menu-card-back {
    position: absolute;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
  }

  .menu-card-back {
    transform: rotateY(180deg);
  }
</style>
