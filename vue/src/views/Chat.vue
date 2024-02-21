<script lang="ts" setup>
import {ref} from 'vue'
import useCable from "@/router/cable";
import Message from "@/views/chat/Message.vue";

useCable("ChatChannel").onReceived((data: any) => {
  console.log(data)
})

</script>

<template>

  <div class="flex flex-col justify-end items-end h-full
              overflow-y-auto overflow-x-hidden p-4">

    <message class="self-start max-w-[80%]"
             @selected="console.log('selected')"/>

  </div>


</template>
