<script setup lang="ts">
import { ref } from "vue";
import { useUserStore } from "../store/user";

const searchInput = ref("");

const submitSearch = () => {
  console.log(searchInput.value);
};

const userStore = useUserStore();
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <section>
        <div class="container items-center gap-6">
          <img src="../assets/imgs/student.png" class="w-56" alt="" />
          <h1 class="text-3xl font-bold">
            Welcome!, {{ userStore.user?.first_name }}
          </h1>
          <div class="relative">
            <input
              type="text"
              class="form-control h-14 w-96 pr-8 pl-5 rounded z-0"
              placeholder="Search for tutors..."
              v-model="searchInput"
            />
            <button
              class="absolute btn right-2 top-2"
              type="button"
              @click="submitSearch"
            >
              Search
            </button>
          </div>
        </div>
      </section>
      <hr class="h-px my-8 bg-blue-200 border-0" />
    </div>
  </div>
</template>

<style></style>
