<script lang="ts" setup>
import PhotoSwipeLightbox from 'photoswipe/lightbox';
import 'photoswipe/style.css';
import {inject, onMounted, onUnmounted, Ref, ref} from "vue";

const props = withDefaults(defineProps<{
  galleryId?: string,
  images: ({
    thumbnailURL: string,
    largeURL?: string,
    width?: number,
    height?: number
  } | string)[]
}>(), {
  galleryId: "i" + Math.random().toString(36).substring(7)
});

const lightbox = ref<PhotoSwipeLightbox | null>(null);

const keep_open = inject<Ref<boolean>>("keep_open", ref(false));

onMounted(() => {
  lightbox.value = new PhotoSwipeLightbox({
    gallery: '#' + props.galleryId,
    children: 'a',
    pswpModule: () => import('photoswipe'),
  });

  lightbox.value.on('beforeOpen', () => keep_open.value = true)
  lightbox.value.on('close', () => keep_open.value = false)

  lightbox.value.init();
});
onUnmounted(() => {
  lightbox.value?.destroy();
  lightbox.value = null;
});

</script>

<template>
  <div :id="galleryId">
    <a
      v-for="(image, key) in images"
      :key="key"
      :data-pswp-height="typeof image === 'string' ? 1080 : image.height || 1080"
      :data-pswp-src="typeof image === 'string' ? image : image.largeURL || image.thumbnailURL"
      :data-pswp-width="typeof image === 'string' ? 1080 : image.width || 1080"
      rel="noreferrer"
      target="_blank"
    >
      <img :src="typeof image === 'string' ? image : image.thumbnailURL" alt="Image"/>
    </a>
  </div>
</template>

<style>
.pswp__button--zoom {
  display: none !important;
}
</style>
