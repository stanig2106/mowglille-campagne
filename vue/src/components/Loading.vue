<script setup lang="ts">
import loading_left from "@/assets/loading_left.png";
import loading_right from "@/assets/loading_right.png";
import logo_full from "@/assets/logo_full.webp";

setTimeout(() =>
    document.getElementById("loading-overlay")!.style.display = "none",
  1000);
</script>

<template>
  <div id="loading-overlay" class="absolute z-50 top-0 left-0 h-screen w-screen overflow-hidden select-none loading">
    <img :src="loading_left" class="absolute top-0 -left-1 h-screen w-screen object-cover loading-left" alt="loading"/>
    <img :src="loading_right" class="absolute top-0 -right-1 h-screen w-screen object-cover loading-right" alt="loading"/>
    <img :src="logo_full" class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 h-2/3 w-2/3 object-contain loading-logo" alt="logo"/>
  </div>
</template>


<style lang="scss">
.loading {
  animation: loading 0.9s ease-in-out forwards;
}

.loading-right {
  animation: loading-right 0.6s cubic-bezier(1, 0.03, 0.33, 0.15) forwards 0.3s;
}

.loading-left {
  animation: loading-left 0.6s cubic-bezier(1, 0.03, 0.33, 0.15) forwards 0.3s;
}

.loading-logo {
  animation: loading-logo 0.7s ease-in-out forwards 0.2s;
}

@keyframes loading-right {
  from {
    transform: translateX(0%);
  }
  to {
    transform: translateX(100%);
  }
}

@keyframes loading-left {
  from {
    transform: translateX(0%);
  }
  to {
    transform: translateX(-100%);
  }
}

@keyframes loading {
  from {
    display: block;
  }
  to {
    display: none;
  }
}

@keyframes loading-logo {
  from {
    transform: translateX(-50%) translateY(-50%) scale(1);
    opacity: 1;
  }
  30% {
    transform: translateX(-50%) translateY(-50%) scale(1.1);
    opacity: 1;
  }
  to {
    transform: translateX(-50%) translateY(-50%) scale(0);
    opacity: 0.3;
  }
}

</style>
