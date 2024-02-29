<script lang="ts" setup>


import {chestColors, chestRarities} from "@/views/collection/chest";
import {computed} from "vue";

export type Rarity = typeof chestRarities[number]

const props = defineProps<{
  rarity: Rarity
  size?: string
}>()

const rarity = computed(() => {
  if (!chestRarities.includes(props.rarity))
    return "rare" as Rarity
  return props.rarity
})


const data = {
  rare: ["Rare", chestColors.rare],
  epic: ["Épic", chestColors.epic],
  legendary: ["Légendaire", chestColors.legendary]
} as const

</script>

<template>
  <div class="flex flex-col items-center text-sm">
    <v-icon :color="data[rarity][1]" :size="size ?? 96" class="-mt-2.5">
      mdi-treasure-chest
    </v-icon>
    <div>
      {{ data[rarity][0] }}
    </div>
  </div>
</template>
