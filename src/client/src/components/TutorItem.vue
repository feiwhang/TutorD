<script setup lang="ts">
import { baseApiUrl } from "../const";
import { Repository } from "../repositories";
import router from "../router";
import { useUserStore } from "../store/user";
import { VerificationStatus } from "../models/enums";
import { PropType } from "vue";
import { ITutorWithCourses } from "../models/db_models";

defineProps({
  tutor: {
    type: Object as PropType<ITutorWithCourses>,
    required: true,
  },
});

const repo = new Repository();
const userStore = useUserStore();

const toggleFavourite = (tutor_id: number) => {
  repo
    .post(`${baseApiUrl}/students/${userStore.user?.id}/favourites`, {
      tutor_id,
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
  <div
    class="border-2 rounded p-6 border-blue-100 flex flex-col gap-2 shadow-lg shadow-blue-500/50"
  >
    <div class="flex justify-between">
      <h2 class="text-blue-500">
        {{ tutor.first_name }} {{ tutor.last_name }}
      </h2>
      <button @click="toggleFavourite(tutor.id)">
        <font-awesome-icon
          :icon="`fa-${tutor.is_favourite ? 'solid' : 'regular'} fa-heart`"
          color="pink"
        />
      </button>
    </div>
    <p class="text-lg">{{ tutor.email }}</p>
    <ul class="flex gap-4 mt-8">
      <li
        :class="`border-2 rounded text-xl p-2 ${
          course.verification_status === VerificationStatus.Verified
            ? 'border-green-500'
            : course.verification_status === VerificationStatus.Pending
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
</template>
