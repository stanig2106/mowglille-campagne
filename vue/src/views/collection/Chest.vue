<script lang="ts" setup>


import {chestColors, chestRarities} from "@/views/collection/chest";

export type Rarity = typeof chestRarities[number]

const props = defineProps<{
  rarity: Rarity
  size?: string
}>()

const data = {
  rare: ["Rare", chestColors.rare],
  epic: ["Épic", chestColors.epic],
  legendary: ["Légendaire", chestColors.legendary]
} as const

</script>

<template>
  <div class="flex flex-col items-center text-sm">
    <v-icon :color="data[rarity][1]" class="-mt-2.5" :size="size ?? 96">
      mdi-treasure-chest
    </v-icon>
    <div>
      {{ data[rarity][0] }}
    </div>
  </div>
</template>
