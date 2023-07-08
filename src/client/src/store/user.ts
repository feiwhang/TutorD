import { defineStore } from "pinia";
import { baseApiUrl } from "../const";
import { LoginRequest, RegisterRequest } from "../models/req_models";
import { IAdmin, IStudent, ITutor } from "../models/db_models";
import { Role } from "../models/enums";

export const useUserStore = defineStore("user", {
  state: () => {
    return {
      user: null as IStudent | ITutor | IAdmin | null,
    };
  },

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
        if (userData.role === Role.Student) {
          this.user = userData as IStudent;
        } else {
          this.user = userData as ITutor;
        }
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
        if (registerRequest.role === Role.Student) {
          this.user = userData as IStudent;
        } else {
          this.user = userData as ITutor;
        }
      }
    },
  },
});
