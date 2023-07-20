<script setup lang="ts">
import { ref } from "vue";
import { useUserStore } from "../store/user";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { useRouter } from "vue-router";
import { ICourse, ITutor } from "../models/db_models";

const userStore = useUserStore();
const router = useRouter();
const searchInput = ref("");

const submitSearch = () => {
  router.push({
    name: "Search",
    query: {
      q: searchInput.value,
    },
  });
};

const courses = ref<ICourse[]>([]);
const favouriteTutors = ref<ITutor[]>([]);

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
  .get(`${baseApiUrl}/students/${userStore.user?.id}/favourites/detail`)
  .then((res) => {
    favouriteTutors.value = res as ITutor[];
  });

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
  <div>
    <div class="container mx-auto p-8">
      <section>
        <div class="container items-center gap-6">
          <img src="../assets/imgs/student.png" class="w-56" alt="" />
          <h1 class="text-3xl font-bold">
            Welcome!, {{ userStore.user?.first_name }}
            {{ userStore.user?.last_name }}
          </h1>
          <div class="relative">
            <input
              type="text"
              class="form-control h-14 w-96 rounded z-0"
              placeholder="Search for tutors..."
              v-model="searchInput"
              @keyup.enter="submitSearch"
            />
            <i
              class="absolute btn right-2 top-2 cursor-pointer"
              @click="submitSearch"
            >
              <font-awesome-icon icon="fa-solid fa-magnifying-glass" />
            </i>
          </div>
        </div>
      </section>
      <hr class="h-1 my-8 bg-blue-100 border-0 rounded" />
      <div class="grid grid-cols-2 max-md:grid-cols-1 gap-12">
        <section class="flex flex-col items-center gap-12">
          <h1 class="text-3xl font-bold text-center">
            <font-awesome-icon icon="fa-regular fa-address-book" />
            Browse Tutors by Courses
          </h1>
          <ul class="grid grid-cols-3 gap-4 max-lg:grid-cols-2">
            <li
              v-for="course in courses"
              class="border rounded p-4 text-center text-ellipsis line-clamp-2 cursor-pointer self-center hover:shadow"
            >
              {{ course.name }}
            </li>
          </ul>
        </section>
        <section class="flex flex-col items-center gap-12">
          <h1 class="text-3xl font-bold text-center">
            <font-awesome-icon icon="fa-regular fa-star" />
            Favourites
          </h1>
          <ul class="space-y-4">
            <li
              v-for="favouriteTutor in favouriteTutors"
              class="border-2 rounded p-6 border-blue-100 flex justify-between gap-8 shadow-lg shadow-blue-500/50"
            >
              <p
                class="text-lg hover:underline hover:cursor-pointer"
                @click="router.go(0)"
              >
                {{ favouriteTutor.first_name }} {{ favouriteTutor.last_name }}
              </p>
              <button
                @click="toggleFavourite(favouriteTutor.id)"
                class="text-2xl"
              >
                <font-awesome-icon icon="fa-solid fa-heart" color="pink" />
              </button>
            </li>
          </ul>
          <p v-if="!favouriteTutors.length" class="text-gray-400">
            You doesn't have any favourite.
          </p>
        </section>
      </div>
    </div>
  </div>
</template>

<style></style>
