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

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  id: number;
  email: string;
  first_name: string;
  last_name: string;
  role: Role;
}
