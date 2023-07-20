import { createApp } from "vue";
import "./assets/main.css";
import App from "./App.vue";
import { createPinia } from "pinia";
import router from "./router";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import {
  faStar,
  faAddressBook,
  faHeart,
} from "@fortawesome/free-regular-svg-icons";
import {
  faMagnifyingGlass,
  faHeart as faHeartSolid,
} from "@fortawesome/free-solid-svg-icons";

library.add(faStar, faMagnifyingGlass, faAddressBook, faHeart, faHeartSolid);

const app = createApp(App);
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

app
  .use(pinia)
  .use(router)
  .component("font-awesome-icon", FontAwesomeIcon)
  .mount("#app");
