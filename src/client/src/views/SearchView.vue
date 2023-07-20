<script setup lang="ts">
import { useRouter } from "vue-router";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { ICourse, ITutor } from "../models/db_models";
import { VerificationStatus } from "../models/enums";
import { ref } from "vue";
import { useUserStore } from "../store/user";

interface ITutorWithCourses extends ITutor {
  is_favourite: boolean;
  courses?: ICourseWithVerificationStatus[];
}

interface ICourseWithVerificationStatus extends ICourse {
  verification_status: VerificationStatus;
}

const router = useRouter();
const repo = new Repository();
const user = useUserStore();

const tutors = ref<ITutorWithCourses[]>([]);

repo
  .get(`${baseApiUrl}/search?q=${router.currentRoute.value.query.q}`)
  .then((res) => {
    tutors.value = res as ITutorWithCourses[];
    tutors.value.forEach((tutor) => {
      repo.get(`${baseApiUrl}/tutors/${tutor.id}/courses`).then((res) => {
        tutor.courses = res as ICourseWithVerificationStatus[];
      });
    });
  });

const toggleFavourite = (tutor_id: number) => {
  repo.post(`${baseApiUrl}/students/${user.user?.id}/favourites`, {
    tutor_id,
  });
};
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <h1 class="text-3xl font-bold">
        Search Result for
        <span class="text-blue-400 font-bold ml-2">
          {{ router.currentRoute.value.query.q }}
        </span>
        <div>
          <ul class="mt-16 space-y-8">
            <li
              class="border-2 rounded p-6 border-blue-100 flex flex-col gap-2 shadow-lg shadow-blue-500/50"
              v-for="tutor in tutors"
            >
              <div class="flex justify-between">
                <h2 class="text-blue-500">
                  {{ tutor.first_name }} {{ tutor.last_name }}
                </h2>
                <button @click="toggleFavourite(tutor.id)">
                  <font-awesome-icon icon="fa-regular fa-heart" color="pink" />
                </button>
              </div>
              <p class="text-lg">{{ tutor.email }}</p>
              <ul class="flex gap-4 mt-8">
                <li
                  :class="`border-2 rounded text-xl p-2 ${
                    course.verification_status === VerificationStatus.Verified
                      ? 'border-green-500'
                      : course.verification_status ===
                        VerificationStatus.Pending
                      ? 'border-gray-500'
                      : 'border-red-500'
                  }`"
                  v-for="course in tutor.courses"
                >
                  {{ course.name }}
                  <font-awesome-icon
                    :icon="`fa-solid ${
                      course.verification_status === VerificationStatus.Verified
                        ? 'fa-check-circle'
                        : course.verification_status ===
                          VerificationStatus.Pending
                        ? 'fa-clock'
                        : 'fa-cancel'
                    }`"
                    :color="`${
                      course.verification_status === VerificationStatus.Verified
                        ? 'green'
                        : course.verification_status ===
                          VerificationStatus.Pending
                        ? 'gray'
                        : 'red'
                    }`"
                  />
                </li>
              </ul>
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
