import { Role } from "./enums";

export interface RegisterRequest {
  email: string;
  password: string;
  first_name: string;
  last_name: string;
  role: Role;
}

export interface RegisterResponse {
  id: number;
  email: string;
  first_name: string;
  last_name: string;
  role: Role;
}
