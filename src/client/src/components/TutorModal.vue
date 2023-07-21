<script setup lang="ts">
import { PropType, ref } from "vue";
import { ICourseWithVerificationStatus, ITutor } from "../models/db_models";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { VerificationStatus } from "../models/enums";

const props = defineProps({
  active: Boolean,
  tutor: {
    type: Object as PropType<ITutor>,
    required: true,
  },
  toggleActive: Function as PropType<() => void>,
});

const repo = new Repository();

const courses = ref<ICourseWithVerificationStatus[]>([]);

repo
  .get(`${baseApiUrl}/tutors/${props.tutor.id}/courses`)
  .then((res) => {
    courses.value = res as ICourseWithVerificationStatus[];
  })
  .catch((err) => {
    alert(err.message);
  });
</script>

<template>
  <div
    v-if="active"
    tabindex="-1"
    aria-hidden="true"
    class="absolute top-0 left-1/4 z-50 w-full p-4 h-full overflow-y-auto overflow-x-hidden outline-none"
  >
    <div
      v-if="active"
      class="bg-gray-900 opacity-80 w-full h-full z-1000 fixed left-0 top-0"
    ></div>
    <div class="relative w-full max-w-2xl max-h-full">
      <div class="relative bg-white rounded-lg shadow">
        <div class="flex items-start justify-between p-4 border-b rounded-t">
          <h3 class="text-2xl font-semibold text-gray-900">
            {{ tutor.first_name }} {{ tutor.last_name }}
          </h3>
          <button
            @click="toggleActive"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-xl w-8 h-8 ml-auto inline-flex justify-center items-center"
          >
            <font-awesome-icon icon="fa-solid fa-close" color="red" />
            <span class="sr-only">Close modal</span>
          </button>
        </div>
        <div class="p-6 space-y-6">
          <ul class="flex gap-4 mt-8">
            <li
              :class="`border-2 rounded text-lg p-2 flex items-center justify-between gap-2 ${
                course.verification_status === VerificationStatus.Verified
                  ? 'border-green-500'
                  : course.verification_status === VerificationStatus.Pending
                  ? 'border-gray-500'
                  : 'border-red-500'
              }`"
              v-for="course in courses"
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
        <div
          class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b justify-end text-md"
        >
          <button
            @click="toggleActive"
            type="button"
            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg px-5 py-2.5 text-center"
          >
            Book a session
          </button>
          <a
            @click="toggleActive"
            type="button"
            :href="`mailto:${tutor.email}`"
            class="cursor-pointer text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-blue-300 rounded-lg border border-gray-200b font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10"
          >
            Send email
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
