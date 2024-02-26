<script lang="ts" setup>
import honey from "@/assets/honey.webp";
import {ProfileImage} from "@/utils/profile_pictures";

const props = defineProps<{
  rank: number | undefined,
  name: string,
  score: number | undefined,
  profile_picture: string | null
}>()
</script>

<template>
  <div class="flex justify-between w-full h-full items-center px-4">
    <div class="flex gap-2 items-center">
      <div class="rounded-full overflow-hidden">
        <v-img v-if="profile_picture"
               :lazy-src="ProfileImage.new(name || 'Profile').png()"
               :src="profile_picture"
               class="rounded-full bg-gray-200" height="48" width="48"/>
        <v-img v-else
               :lazy-src="ProfileImage.new(name || 'Profile').png()"
               :src="ProfileImage.new(name || 'Profile').png()"
               class="rounded-full bg-gray-200" height="48" width="48"/>
      </div>

      <div class="flex flex-col gap-1 justify-center">
        <h1 class="text-3xl">
          {{ rank == 0 || rank == undefined ? "# -" : "#" + rank }}
        </h1>
        <div class="text-lg text-gray-500 pr-2 one-line">
          {{ name }}
        </div>
      </div>
    </div>

    <div class="bg-gray-400 bg-opacity-40 rounded-lg p-2 flex justify-end gap-2">
      <h1 class="text-xl">
        {{ score ?? "-" }}
      </h1>
      <v-img :src="honey" :transition="false" class="h-6 w-6 mt-0.5"/>
    </div>
  </div>
</template>
