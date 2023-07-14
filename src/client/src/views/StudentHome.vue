<script setup lang="ts">
import { ref } from "vue";
import { useUserStore } from "../store/user";
import { Course } from "../models";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";

const userStore = useUserStore();
const searchInput = ref("");

const submitSearch = () => {
  console.log(searchInput.value);
};

const courses = ref<Course[]>([]);

const repo = new Repository();
repo
  .get(`${baseApiUrl}/courses`)
  .then((res) => {
    courses.value = res as Course[];
  })
  .catch((err) => {
    alert(err.message);
  });
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
          <p class="text-gray-400">You doesn't have any favourite.</p>
        </section>
      </div>
    </div>
  </div>
</template>

<style></style>
