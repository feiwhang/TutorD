<script setup lang="ts">
import { useUserStore } from "../store/user";

const userStore = useUserStore();

const logout = () => {
  userStore.logout();
};
</script>

<template>
  <div class="bg-blue-500">
    <div class="container relative">
      <nav class="flex items-center justify-between flex-wrap py-6">
        <div class="flex items-center flex-shrink-0 text-white mr-6">
          <a class="font-bold text-3xl tracking-tight" href="/">TutorD</a>
        </div>
        <div class="flex items-center justify-center gap-8">
          <template v-if="!userStore.user">
            <a href="/login" class="text-white">Login</a>
          </template>
          <template v-else>
            <button @click="logout" class="text-white">Logout</button>
          </template>
        </div>
      </nav>
    </div>
  </div>
</template>

<style scoped>
.link {
  @apply block md:inline-block md:mt-0 text-white hover:text-indigo-100;
}
.link-mobile {
  @apply text-xl;
}
</style>
