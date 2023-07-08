<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/user";
import { RegisterRequest } from "../models/req_models";
import { Role } from "../models/enums";

const registerFormData = ref<RegisterRequest>({
  email: "",
  password: "",
  first_name: "",
  last_name: "",
  role: Role.Student,
});

const confirmPassword = ref("");
const error = ref("");

const router = useRouter();
const userStore = useUserStore();

const register = () => {
  if (registerFormData.value.password !== confirmPassword.value) {
    error.value = "Passwords do not match";
    return;
  }
  userStore.register(registerFormData.value).then(() => {
    if (userStore.user) {
      router.push("/");
    }
  });
};
</script>

<template>
  <div class="container mt-36">
    <div class="flex flex-col items-center content-center gap-9">
      <h1 class="text-3xl font-bold">Get Started</h1>
      <form
        class="flex flex-col content-center gap-4"
        action="#"
        @submit.prevent="register"
      >
        <div class="form-group">
          <label for="firstName" class="font-bold">First Name</label>
          <input
            id="firstName"
            type="text"
            class="form-control"
            name="firstName"
            required
            autofocus
            v-model="registerFormData.first_name"
          />
        </div>
        <div class="form-group">
          <label for="lastName" class="font-bold">Last Name</label>
          <input
            id="lastName"
            type="text"
            class="form-control"
            name="lastName"
            required
            autofocus
            v-model="registerFormData.last_name"
          />
        </div>
        <div class="form-group">
          <label for="email" class="font-bold">Email</label>
          <input
            id="email"
            type="email"
            class="form-control"
            name="email"
            required
            autofocus
            v-model="registerFormData.email"
          />
        </div>

        <div class="form-group">
          <label for="password" class="font-bold">Password</label>
          <input
            id="password"
            type="password"
            class="form-control"
            name="password"
            required
            v-model="registerFormData.password"
          />
        </div>

        <div class="form-group">
          <label for="confirmPassword" class="font-bold"
            >Confirm Password</label
          >
          <input
            id="confirmPassword"
            type="password"
            class="form-control"
            name="confirmPassword"
            required
            v-model="confirmPassword"
          />
        </div>

        <div class="flex flex-row gap-2 border rounded p-2 items-center">
          <p class="font-bold text-lg">I am a</p>
          <button
            :class="
              `${
                registerFormData.role == Role.Student ? 'btn' : 'btn-inactive'
              }` + ' m-1'
            "
            @click="registerFormData.role = Role.Student"
            type="button"
          >
            Student
          </button>
          <button
            :class="
              `${
                registerFormData.role == Role.Tutor ? 'btn' : 'btn-inactive'
              }` + ' m-1'
            "
            @click="registerFormData.role = Role.Tutor"
            type="button"
          >
            Tutor
          </button>
        </div>

        <p class="text-red-400 self-center mt-5">{{ error }}</p>

        <div class="form-group self-center m-5">
          <button type="submit" class="btn">Register</button>
        </div>

        <div class="flex gap-1 self-center">
          <p>Already a member?</p>
          <a href="/login" class="text-blue-500 hover:underline">Login</a>
        </div>
      </form>
    </div>
  </div>
</template>

<style scoped>
.btn {
  @apply font-bold py-2 px-4 rounded text-white bg-blue-500 shadow-lg shadow-blue-500/50 transition-shadow;
}

.btn:hover {
  @apply shadow-xl shadow-blue-500/50;
}

.btn:disabled {
  @apply bg-blue-300 cursor-not-allowed;
}

.btn:disabled:hover {
  @apply bg-blue-300 cursor-not-allowed shadow-lg shadow-blue-500/50;
}

.btn-inactive {
  @apply font-bold py-2 px-4 rounded text-white bg-blue-200  transition-shadow;
}
</style>
