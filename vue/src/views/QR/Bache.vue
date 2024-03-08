<script lang="ts" setup>

function device_type() {
  const ua = navigator.userAgent;

  //@ts-ignore
  if (/iPad|iPhone|iPod/.test(ua) && !window.MSStream) {
    return "ios";
  } else if (/android/i.test(ua)) {
    return "android";
  } else {
    return "other";
  }
}

if (device_type() === "ios")
  window.location.href = "https://apps.apple.com/fr/app/mowglille/id6475304610";
else if (device_type() === "android")
  window.location.href = "https://play.google.com/store/apps/details?id=fr.mowglille.twa&hl=fr&gl=FR";
else
  window.location.href = "https://mowglille.fr/get_app";

</script>

<template>
  <div/>
</template>
