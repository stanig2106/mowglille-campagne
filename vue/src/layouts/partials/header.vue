<script setup lang="ts">


const props = defineProps<{
  back: string | null
}>()
</script>

<template>
  <div class="bg-primary top-0 absolute h-16 w-full
              flex justify-between">

    <h1 class="h-full flex items-center text-3xl italic mt-0.5 ml-4"
        v-if="back == null">
      MOWG'LILLE
    </h1>

    <h1 class="h-full flex items-center text-3xl italic mt-0.5"
        v-else>
      <v-btn icon variant="text" rounded="lg"
             @click="$router.go(-1)">
        <v-icon size="32">
          mdi-arrow-left
        </v-icon>
      </v-btn>
      {{ back }}
    </h1>

    <div class="h-full flex justify-end items-center mr-2"
         v-if="back == null">
      <v-btn icon variant="text" rounded="lg">
        <v-icon size="32">
          mdi-instagram
        </v-icon>
      </v-btn>

      <v-btn icon variant="text" rounded="lg">
        <v-icon size="32">
          mdi-facebook
        </v-icon>
      </v-btn>

      <!--      notifications s-->

      <v-btn icon variant="text" rounded="lg">
        <v-badge dot color="red" v-if="true">
          <v-icon size="32">
            mdi-bell
          </v-icon>
        </v-badge>

        <v-icon size="32" v-else>
          mdi-bell
        </v-icon>

        <v-menu activator="parent" close-on-back scrim="9CA38F">
          <v-list density="compact">
            <v-list-subheader>Notifications</v-list-subheader>
            <v-list-item value>
              <v-list-item-title>
                <div class="flex items-center justify-between">
                  Test
                  <v-badge inline color="red" dot v-if="true"/>
                </div>
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-btn>


    </div>

  </div>
  <div class="bg-primary top-0 z-10 sticky h-1" id="header-clip"/>
</template>

<style lang="scss">
h1 {
  font-family: "QuintoAndatTextos-Bold", sans-serif !important;
}
</style>
