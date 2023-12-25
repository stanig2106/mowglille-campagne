<script lang="ts" setup>

import Score from "@/views/home/Score.vue";
import CurrentEvent from "@/views/home/CurrentEvent.vue";
import CollectionBtn from "@/views/home/btns/CollectionBtn.vue";
import OneLineBtn from "@/views/home/btns/OneLineBtn.vue";
</script>

<template>
  <div class="flex flex-col gap-4 h-full overflow-auto">
    <Score/>
    <CurrentEvent event_name="Le Livre de la Jungle"/>
    <div class="h-full bg-white rounded-t-2xl elevation-2 p-4 flex flex-col gap-2">
      <CollectionBtn class="w-full"/>
      <div class="flex gap-2 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-trophy" title="Liste des defis"/>
        <OneLineBtn :icon-size="32" icon="mdi-nintendo-game-boy" title="Jeu"/>
      </div>
      <div class="flex gap-2 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-calendar-clock" title="Planning"/>
        <OneLineBtn :icon-size="32" icon="mdi-script-text-outline" title="Programme" disabled/>
      </div>
      <div class="flex gap-2 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-image-frame" title="Trombi"/>
        <OneLineBtn :icon-size="32" icon="mdi-message-outline" title="Contact nous"/>
      </div>
      <OneLineBtn :icon-size="32" icon="mdi-image-multiple" title="Galerie" disabled/>

    </div>
  </div>
</template>


