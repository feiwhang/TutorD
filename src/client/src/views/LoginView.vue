<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/user";
import { LoginRequest } from "../models/req_models";

const loginFormData = ref<LoginRequest>({
  email: "",
  password: "",
});

const error = ref("");

const router = useRouter();
const userStore = useUserStore();

const login = () => {
  userStore
    .login(loginFormData.value)
    .then(() => {
      if (userStore.user) {
        router.push("/");
      }
    })
    .catch((e) => alert(e.message));
};
</script>

<template>
  <div class="container mt-36">
    <div class="flex flex-col items-center content-center gap-9">
      <h1 class="text-3xl font-bold">Log in to Your Account</h1>
      <form
        class="flex flex-col content-center gap-4"
        action="#"
        @submit.prevent="login"
      >
        <div class="form-group">
          <label for="email" class="font-bold">Email</label>
          <input
            id="email"
            type="email"
            class="form-control"
            name="email"
            required
            autofocus
            v-model="loginFormData.email"
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
            v-model="loginFormData.password"
          />
        </div>

        <p class="text-red-400 self-center mt-5">{{ error }}</p>

        <div class="form-group self-center m-5">
          <button type="submit" class="btn">Log In</button>
        </div>

        <div class="flex gap-1 self-center">
          <p>Not a member yet?</p>
          <a href="/register" class="text-blue-500 hover:underline">Register</a>
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
