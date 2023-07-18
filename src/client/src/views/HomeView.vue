<script setup lang="ts">
import { computed } from "vue";
import { useUserStore } from "../store/user";
import { Role } from "../models/enums";
import TutorHome from "./TutorHome.vue";
import StudentHome from "./StudentHome.vue";
import AdminHome from "./AdminHome.vue";

const userStore = useUserStore();
const user = computed(() => userStore.user);
</script>

<template>
  <TutorHome v-if="user && user.role === Role.Tutor" />
  <StudentHome v-if="user && user.role === Role.Student" />
  <AdminHome v-if="user && user.role === Role.Admin" />
</template>
