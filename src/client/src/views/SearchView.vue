<script setup lang="ts">
import { useRouter } from "vue-router";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { Tutor } from "../models";
import { ref } from "vue";

const router = useRouter();

const repo = new Repository();

const tutors = ref<Tutor[]>([]);
repo
  .get(`${baseApiUrl}/search?q=${router.currentRoute.value.query.q}`)
  .then((res) => {
    tutors.value = res as Tutor[];
  });
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <h1 class="text-3xl font-bold">
        Search Result for
        <span class="text-blue-500 font-bold ml-2">
          {{ router.currentRoute.value.query.q }}
        </span>
        <div>
          <ul class="mt-8">
            <li v-for="tutor in tutors">{{ tutor }}</li>
          </ul>
          <p v-if="tutors.length === 0" class="text-xl text-gray-500">
            No matching tutors.
          </p>
        </div>
      </h1>
    </div>
  </div>
</template>

<style></style>
