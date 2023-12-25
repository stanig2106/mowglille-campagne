<script setup lang="ts">

import fake_qrcode from "@/assets/fake/QRCode.png";

async function generateQRCode() {
}

</script>

<template>

  <div class="bg-white rounded-t-2xl p-4 flex flex-col justify-center elevation-2 h-full gap-4"
       @click="generateQRCode">
    <div class="w-full mb-4">
      <v-img :src="fake_qrcode" class="w-4/5 mx-auto max-h-[60vh]"/>
    </div>

    <h2 class="text-center text-2xl">
      Arthur Nobrega
    </h2>

    <span class="text-center text-gray-500 text-xs px-6">
      Ce QR Code est unique à votre compte et permet aux différents staffeurs
      de vous identifier. Il vous permettra de gagner des points. <br> <br>
      Attention, ce QR Code est valide qu'une seule fois et pendant 1 minute, cliquez sur
      l'écran pour en générer un nouveau.
    </span>
  </div>


</template>

