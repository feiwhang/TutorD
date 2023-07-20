import { createRouter, createWebHistory } from "vue-router";
import RegisterView from "./views/RegisterView.vue";
import LoginView from "./views/LoginView.vue";
import HomeView from "./views/HomeView.vue";
import BrowseView from "./views/BrowseView.vue";
import { useUserStore } from "./store/user";

const routes = [
  { path: "/", name: "Home", component: HomeView },
  { path: "/register", name: "Register", component: RegisterView },
  {
    path: "/login",
    name: "Login",
    component: LoginView,
  },
  {
    path: "/search",
    name: "Search",
    component: () => import("./views/SearchView.vue"),
  },
  {
    path: "/browse",
    name: "Browse",
    component: BrowseView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach(async (to) => {
  const publicPages = ["/login", "/register"];
  const authRequired = !publicPages.includes(to.path);
  const authPrevented = publicPages.includes(to.path);
  const userStore = useUserStore();
  const user = userStore.user;

  if (authRequired && !user) {
    return "/login";
  }

  if (authPrevented && user) {
    alert("You're already logged in!");
    return "/";
  }

  document.title = `${to.name?.toString() ?? "TutorD"} - Connect Wisdom`;
});

export default router;
