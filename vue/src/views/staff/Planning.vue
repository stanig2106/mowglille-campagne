<script lang="ts" setup>
import {useUserStore} from "@/stores/user_store";
import {computed, ref} from "vue";
import router from "@/router";
import {usePlanningStore} from "@/stores/planning_store";
import PlanningEvent from "@/components/PlanningEvent.vue";

const currentUser = useUserStore()
currentUser.updateUser()

if (!currentUser.staffRoles?.includes("SEE_PLANNING"))
  router.replace("/")

const planningStore = usePlanningStore()

const open_sheet = () => window.open(planningStore.sheet_link!, '_blank')

const selected_day = ref(0)
const day = computed(() => planningStore.days[selected_day.value])

planningStore.updatePlanning()

</script>

<template>
  <div class="bg-white rounded-t-2xl p-2 flex flex-col elevation-2 min-h-full relative h-full">
    <div class="flex items-center justify-between px-4">
      <v-btn :disabled="selected_day == 0"
             icon rounded="lg" @click="selected_day--">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <v-card class="text-2xl font-bold !underline !p-2" variant="text" @click="">
        {{ day.dayOfWeek }} {{ day.date }}

        <v-dialog activator="parent">
          <v-card>
            <v-card-title>
              <span class="text-lg">Information du {{ day.dayOfWeek }} {{ day.date }}</span>
            </v-card-title>
            <v-card-text>
              Bla bla bla, ici tu peux nous tunnel marco
            </v-card-text>
            <v-card-actions>
              <v-spacer/>
              <v-btn color="secondary" @click="open_sheet">
                Ouvrir le sheet
              </v-btn>
            </v-card-actions>
          </v-card>

        </v-dialog>
      </v-card>
      <v-btn :disabled="selected_day == planningStore.days.length - 1"
             icon rounded="lg" @click="selected_day++">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </div>

    <div class="flex-grow-1 mt-2 h-full overflow-y-auto">
      <div class="grid align-start content-start gap-2 pt-4"
           style="grid-template-columns: 0fr 1fr">
        <planning-event :duration="315" start-label="13h00" top-line/>

        <planning-event :duration="15" :style="{backgroundColor: 'rgb(209,209,209)'}"
                        start-label="18h15" @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>
          <div class="flex flex-center h-full">
            Box+F221+F114+Au
          </div>
        </planning-event>
        <planning-event :duration="30" :style="{backgroundColor: 'rgb(209,209,209)'}"
                        start-label="18h30"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            CLAP + F221 + F114
          </div>
        </planning-event>
        <planning-event :duration="60" :style="{backgroundColor: 'rgb(255, 255, 255)'}"
                        start-label="19h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            Inst. CONFESSIONNAL
          </div>
        </planning-event>
        <planning-event :duration="60" :style="{backgroundColor: 'rgb(246,203,80)'}"
                        start-label="20h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            CONFESSIONNAL
          </div>
        </planning-event>
        <planning-event :duration="60" :style="{backgroundColor: 'rgb(81,245,245)'}"
                        start-label="21h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            REPAS
          </div>
        </planning-event>
        <planning-event :duration="60" :style="{backgroundColor: 'rgb(246,146,245)'}"
                        start-label="22h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            SECRET STORY
          </div>
        </planning-event>
        <planning-event :duration="60" :style="{backgroundColor: 'rgb(9,206,116)'}"
                        start-label="23h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            PORTE
          </div>
        </planning-event>
        <planning-event :duration="45" :style="{backgroundColor: 'rgb(245,245,245)'}"
                        start-label="00h00"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            Rgt. CONFESSIONNAL
          </div>
        </planning-event>
        <planning-event :duration="30" :style="{backgroundColor: 'rgb(245,245,245)'}"
                        start-label="00h45"
                        @click="">
          <v-dialog activator="parent">
            <v-card>
              <v-card-title>
                <span class="text-lg">Information</span>
              </v-card-title>
              <v-card-text>
                Bla bla bla, ici tu peux nous tunnel, mettre des lien et des infos complémentaires !
              </v-card-text>
            </v-card>
          </v-dialog>

          <div class="flex flex-center h-full">
            Rgt. CONFESSIONNAL
          </div>
        </planning-event>

        <planning-event :duration="165" bottom-line end-label="3h00" start-label="1h15"/>

      </div>
    </div>


  </div>
</template>
