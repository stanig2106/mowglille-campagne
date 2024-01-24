<script lang="ts" setup>

import generate from "@/views/games/safariSprint/core/generators";
import {lineToS} from "@/views/games/safariSprint/core/utils";

console.log('hello world')

for (let i = 0; i < 10; i++)
  console.log(lineToS(generate(null)))

</script>

<template>
  <div>

  </div>
</template>

