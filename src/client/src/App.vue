<script setup lang="ts">
import { useFetch } from "@vueuse/core";
const { data, isFetching, error } = useFetch(
  "http://localhost:5001/api/courses"
)
  .get()
  .json();
</script>

<template>
  <div>
    <h1 class="text-lg">EIEI</h1>
    <p>{{ error }}</p>
    <ul>
      <li v-if="!isFetching" v-for="(course, index) in data" :key="index">
        {{ course.name }}
      </li>
    </ul>
  </div>
</template>

<style></style>
