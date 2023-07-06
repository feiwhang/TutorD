<script setup lang="ts">
import { fetchCourses } from "./services.js";

const courses = await fetchCourses();
</script>

<template>
  <div>
    <ul>
      <li v-for="(course, index) in courses" :key="index">{{ course.name }}</li>
    </ul>
  </div>
  <HelloWorld msg="Vite + Vue" />
</template>

<style scoped></style>
./services.js
