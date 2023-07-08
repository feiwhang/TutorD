import { createRouter, createWebHistory } from "vue-router";
import RegisterView from "./views/RegisterView.vue";
import LoginView from "./views/LoginView.vue";

const routes = [
  { path: "/register", name: "Register", component: RegisterView },
  {
    path: "/login",
    name: "Login",
    component: LoginView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
