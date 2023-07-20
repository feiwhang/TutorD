<script setup lang="ts">
import { ref } from "vue";
import { useUserStore } from "../store/user";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { useRouter } from "vue-router";
import { ICourse, ICourseWithVerificationStatus } from "../models/db_models";
import { VerificationStatus } from "../models/enums";

const userStore = useUserStore();
const router = useRouter();
const newCourseSelected = ref("");

const offeringCourses = ref<ICourseWithVerificationStatus[]>([]);
const courses = ref<ICourse[]>([]);

const repo = new Repository();
repo
  .get(`${baseApiUrl}/courses`)
  .then((res) => {
    courses.value = res as ICourse[];
  })
  .catch((err) => {
    alert(err.message);
  });

repo
  .get(`${baseApiUrl}/tutors/${userStore.user?.id}/courses`)
  .then((res) => {
    offeringCourses.value = res as ICourseWithVerificationStatus[];
  })
  .catch((err) => {
    alert(err.message);
  });

const addNewCourse = () => {
  repo
    .post(`${baseApiUrl}/tutors/${userStore.user?.id}/courses`, {
      course_id: courses.value.find((c) => c.name === newCourseSelected.value)
        ?.id,
    })
    .then(() => {
      router.go(0);
    })
    .catch((err) => {
      alert(err.message);
    });
};
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <section>
        <div class="container items-center gap-6">
          <img src="../assets/imgs/teacher.png" class="w-56" alt="" />
          <h1 class="text-3xl font-bold">
            Welcome!, {{ userStore.user?.first_name }}
            {{ userStore.user?.last_name }}
          </h1>
          <div
            class="flex align-middle justify-center items-center gap-8 text-lg border-gray-300 text-gray-900 rounded"
          >
            <label for="courses" class="">Offer new course</label>
            <select id="courses" v-model="newCourseSelected" class="border p-6">
              <option
                v-for="course in courses"
                :selected="course.name === newCourseSelected"
              >
                {{ course.name }}
              </option>
            </select>
            <button type="button" @click="addNewCourse">
              <font-awesome-icon icon="fa-solid fa-add" />
            </button>
          </div>
        </div>
      </section>
      <hr class="h-1 my-8 bg-blue-100 border-0 rounded" />
      <div class="">
        <ul class="space-y-8 flex flex-col justify-center align-middle">
          <li
            class="text-2xl border-2 rounded p-6 border-blue-100 gap-2 shadow-lg shadow-blue-500/50 flex align-middle justify-between"
            v-for="course in offeringCourses"
          >
            <p>{{ course.name }}</p>
            <font-awesome-icon
              :icon="`fa-solid ${
                course.verification_status === VerificationStatus.Verified
                  ? 'fa-check-circle'
                  : course.verification_status === VerificationStatus.Pending
                  ? 'fa-clock'
                  : 'fa-cancel'
              }`"
              :color="`${
                course.verification_status === VerificationStatus.Verified
                  ? 'green'
                  : course.verification_status === VerificationStatus.Pending
                  ? 'gray'
                  : 'red'
              }`"
            />
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<style></style>
