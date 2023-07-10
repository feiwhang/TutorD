import { defineStore } from "pinia";
import { baseApiUrl } from "../const";
import { LoginRequest, RegisterRequest } from "../models/req_models";
import { Role } from "../models/enums";

interface IUser {
  id: number;
  email: string;
  first_name: string;
  last_name: string;
  role: Role;
}

export const useUserStore = defineStore("user", {
  state: () => {
    return {
      user: null as IUser | null,
    };
  },
  persist: true,
  actions: {
    async login(loginRequest: LoginRequest) {
      const res = await fetch(`${baseApiUrl}/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(loginRequest),
      });
      const successResponse = await res.json();
      alert(successResponse.message);
      if (res.status === 200) {
        const userData = successResponse.user;
        this.user = userData as IUser;
      }
    },
    async register(registerRequest: RegisterRequest) {
      const res = await fetch(`${baseApiUrl}/register`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(registerRequest),
      });
      const successResponse = await res.json();
      alert(successResponse.message);
      if (res.status === 201) {
        const userData = successResponse.user;
        this.user = userData as IUser;
      }
    },
    logout() {
      this.user = null;
    },
  },
});
