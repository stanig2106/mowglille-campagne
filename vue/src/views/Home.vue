<script lang="ts" setup>

import Score from "@/views/home/Score.vue";
import CurrentEvent from "@/views/home/CurrentEvent.vue";
import CollectionBtn from "@/views/home/btns/CollectionBtn.vue";
import OneLineBtn from "@/views/home/btns/OneLineBtn.vue";
import router from "@/router";
import {saveSubscription} from "@/utils/notification";
import {computed, onMounted, ref, watch} from "vue";
import {useUserStore} from "@/stores/user_store";
import {VueShowdown as VShowdown} from "vue-showdown";
import axios from "axios";
import {informShowKey} from "@/router/keys";
import {VueShowdown} from "vue-showdown";

onMounted(saveSubscription)

const currentUser = useUserStore()
currentUser.updateUser()

const as_notif = computed(() => currentUser.fullscreen_msg !== null)
watch(as_notif, (v) => {
  if (v) return
  axios.post("/user/fullscreen_msg")
})

// const need_welcomed = computed(() => currentUser.welcomed === false)
// watch(need_welcomed, (v) => {
//   if (v) return
//   axios.post("/user/welcomed")
// })
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
        <OneLineBtn :icon-size="32" icon="mdi-chart-timeline-variant-shimmer" title="Fil rouge - Lot à gagner"
                    @click="router.push('/fil_rouge')"/>
      </div>
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

<!--  <v-dialog v-model="need_welcomed" persistent>-->
<!--    <v-card>-->
<!--      <v-card-title>-->
<!--        Bienvenue sur Mowgli-->
<!--      </v-card-title>-->
<!--      <v-card-text>-->
<!--        <div class="leading-6">-->
<!--          Salut les oursons 🐻 ! <br><br>-->

<!--          Ces campagnes on vous régale avec ✨2 jeux✨ : <br>-->
<!--          Le premier qui réussit à compléter le puzzle gagnera une switch 🎮 <br>-->
<!--          A la fin des campagnes, les oursons avec le plus de miel 🍯 choisiront leur lot en premier <br><br>-->

<!--          Comment gagner des pièces de puzzle 🧩 et du miel 🍯 ? <br>-->
<!--          <p class="mb-1 mt-2">-->
<!--            Pour obtenir des coffres tu peux : <br>-->
<!--          </p>-->
<!--          🎁 Les pièces de puzzle se trouvent dans les coffres que vous pouvez gagner pendant nos activités ! <br>-->
<!--          🎁 Mettre le filtre soutien actif en photo de profil facebook (le filtre est facile à mettre dans l’espace profil de l’app !) <br>-->
<!--          🎁 Participer aux activités lors de tous nos événements (repas, après-midi…) <br>-->
<!--          🎁 Réaliser les défis disponibles sur l’application <br>-->
<!--          🎁 Être dans le TOP 10 d’un jeu mobile de l'application à la fin des campagnes <br><br>-->

<!--          La liste des lots sera disponible sous peu sur l’application, et on vous garantit que c’est mielleux !<br><br>-->

<!--          En vous souhaitant les meilleures campagnes possibles, big love 🫶🐻🍯-->
<!--        </div>-->
<!--      </v-card-text>-->
<!--      <v-card-actions>-->
<!--        <v-spacer/>-->
<!--        <v-btn variant="text" @click="currentUser.welcomed = true">-->
<!--          J'ai compris-->
<!--        </v-btn>-->
<!--      </v-card-actions>-->
<!--    </v-card>-->
<!--  </v-dialog>-->

  <v-dialog v-model="as_notif" persistent>
    <v-card>
      <v-card-title>
        Information
      </v-card-title>
      <v-card-text>
        <v-showdown :markdown="currentUser.fullscreen_msg"
                    :options="{underline: true, emoji: true}"/>
      </v-card-text>
      <v-card-actions>
        <v-spacer/>
        <v-btn variant="text" @click="currentUser.fullscreen_msg = null">
          J'ai compris
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>


