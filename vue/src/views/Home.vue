<script lang="ts" setup>

import Score from "@/views/home/Score.vue";
import CurrentEvent from "@/views/home/CurrentEvent.vue";
import CollectionBtn from "@/views/home/btns/CollectionBtn.vue";
import OneLineBtn from "@/views/home/btns/OneLineBtn.vue";
import router from "@/router";
import event_bg from '@/assets/fake/event_bg.png'
import {saveSubscription} from "@/utils/notification";
import {onMounted} from "vue";

onMounted(saveSubscription)
</script>

<template>
  <div class="flex flex-col gap-4 h-full overflow-y-auto">
    <Score/>

    <CurrentEvent :background_url="event_bg" event_name="Le Livre de la Jungle" event_type="Aprèm"/>

    <div class="h-full bg-white rounded-t-2xl elevation-2 square-shadow p-4 flex flex-col gap-4">
      <CollectionBtn class="w-full" @click="router.push('/collection')"/>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-trophy" title="Liste des défis"
                    @click="router.push('/challenges')"/>
        <OneLineBtn :icon-size="32" icon="mdi-nintendo-game-boy" title="Jeu"
                    @click="router.push('/games/human_benchmark')"/>
      </div>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-calendar-clock" title="Planning"/>
        <OneLineBtn :icon-size="32" disabled icon="mdi-script-text-outline" title="Programme"/>
      </div>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-image-frame" title="Trombi"/>
        <OneLineBtn :icon-size="32" icon="mdi-message-outline" title="Contact nous"/>
      </div>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-image-multiple" title="Galerie"/>
        <OneLineBtn :icon-size="32" icon="mdi-link-variant" title="Liens utiles"
                    @click="() => $router.push('/links')"/>
      </div>

    </div>
  </div>
</template>


