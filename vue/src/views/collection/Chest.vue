<script lang="ts" setup>


import {chestRarities} from "@/views/collection/chest";

export type Rarity = typeof chestRarities[number]

const props = defineProps<{
  rarity: Rarity
}>()

const data = {
  rare: ["Rare", "green"],
  epic: ["Épic", "purple"],
  legendary: ["Légendaire", "yellow"]
} as const

</script>

<template>
  <div class="flex flex-col items-center text-sm relative h-[96px] aspect-square">
    <v-icon :color="data[rarity][1]" class="-mt-2.5" size="96">
      mdi-treasure-chest
    </v-icon>
    <div class="bottom-1 absolute">
      {{ data[rarity][0] }}
    </div>
  </div>
</template>
