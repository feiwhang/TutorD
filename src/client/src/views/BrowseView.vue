<script setup lang="ts">
import { useRouter } from "vue-router";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import {
  ITutorWithCourses,
  ICourseWithVerificationStatus,
} from "../models/db_models";
import { ref } from "vue";
import { useUserStore } from "../store/user";
import TutorItem from "../components/TutorItem.vue";

const router = useRouter();
const repo = new Repository();
const userStore = useUserStore();

const tutors = ref<ITutorWithCourses[]>([]);

console.log(router.currentRoute.value.params);
repo
  .get(
    `${baseApiUrl}/courses/${router.currentRoute.value.query.course_id}/tutors`
  )
  .then((res) => {
    tutors.value = res as ITutorWithCourses[];
    tutors.value.forEach((tutor) => {
      repo.get(`${baseApiUrl}/tutors/${tutor.id}/courses`).then((res) => {
        tutor.courses = res as ICourseWithVerificationStatus[];
      });
      repo
        .get(`${baseApiUrl}/students/${userStore.user?.id}/favourites`)
        .then((res) => {
          const favourites = res as number[];
          tutor.is_favourite = favourites.includes(tutor.id);
        });
    });
  });
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <h1 class="text-3xl font-bold">
        Browse Result for
        <span class="text-blue-400 font-bold ml-2">
          {{ router.currentRoute.value.query.q }}
        </span>
        <div>
          <ul class="mt-16 space-y-8">
            <li v-for="tutor in tutors">
              <TutorItem :tutor="tutor" />
            </li>
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
