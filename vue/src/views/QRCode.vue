<script setup lang="ts">

import axios from "axios";
import {onUnmounted, ref} from "vue";
import Qrious from "vue-qrious";


const qr_code_content = ref("a".repeat(30))
const loading = ref(true)

// every 60 seconds
const interval = setInterval(generateQRCode, 60 * 1000)

onUnmounted(() => clearInterval(interval))

async function generateQRCode() {
  loading.value = true
  const fake_loading = new Promise(resolve => setTimeout(resolve, 300))
  const {data, status} = await axios.get("/qr_code")
  if (status !== 200) return

  await fake_loading

  loading.value = false
  qr_code_content.value = data.content
}

generateQRCode()

</script>

<template>

  <div class="bg-white rounded-t-2xl p-4 flex flex-col justify-center elevation-2 h-full gap-4"
       @click="generateQRCode">
    <div class="w-full mb-4">
      <qrious :value="qr_code_content" class="w-4/5 mx-auto max-h-[60vh]" id="qrcode"
              :class="{ 'blur-md': loading }"
      />
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


<style lang="scss">
#qrcode {
  transition: filter 0.7s;
}
</style>
