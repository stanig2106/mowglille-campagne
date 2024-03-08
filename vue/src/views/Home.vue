<script lang="ts" setup>

import Score from "@/views/home/Score.vue";
import CurrentEvent from "@/views/home/CurrentEvent.vue";
import CollectionBtn from "@/views/home/btns/CollectionBtn.vue";
import OneLineBtn from "@/views/home/btns/OneLineBtn.vue";
import router from "@/router";
import {saveSubscription} from "@/utils/notification";
import {onMounted} from "vue";
import {useUserStore} from "@/stores/user_store";
import axios from "axios";
import {informShowKey} from "@/router/keys";

onMounted(saveSubscription)

const currentUser = useUserStore()
currentUser.updateUser()
</script>

<template>
  <div class="flex flex-col gap-4 h-full">
    <Score/>

    <CurrentEvent/>

    <div class="h-full bg-white rounded-t-2xl elevation-2 square-shadow p-4 flex flex-col gap-4
                  >:overflow-hidden">
      <CollectionBtn :chest_count="currentUser.chests?.length || 0"
                     :piece_count="currentUser.collection_pieces?.length || 0"
                     class="w-full" @click="router.push('/collection')"/>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-trophy" title="Liste des défis"
                    @click="router.push('/challenges')"/>
        <OneLineBtn :icon-size="32" icon="mdi-nintendo-game-boy" title="Jeu"
                    @click="router.push('/games/human_benchmark')"/>
      </div>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-calendar-clock" title="Planning"
                    @click="router.push('/planning')"/>
        <OneLineBtn :icon-size="32" icon="mdi-script-text-outline" title="Programme"
                    @click="router.push('/program')"/>
      </div>
      <div class="flex gap-4 >:flex-grow w-full">
        <OneLineBtn :icon-size="32" icon="mdi-image-frame" title="Trombi"
                    @click="router.push('/trombi')"/>
        <OneLineBtn :icon-size="32" icon="mdi-link-variant" title="Liens utiles"
                    @click="() => $router.push('/links')"/>
      </div>

    </div>
  </div>
</template>


