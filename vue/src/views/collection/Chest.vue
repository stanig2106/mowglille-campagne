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
  <div class="flex flex-col gap-1 items-center">
    <v-icon :color="data[rarity][1]" size="96">
      mdi-treasure-chest
    </v-icon>
    {{ data[rarity][0] }}
  </div>


</template>
