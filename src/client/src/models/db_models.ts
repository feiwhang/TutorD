// models.ts

import { VerificationStatus } from "./enums";

export interface IStudent {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface ITutor {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface IAdmin {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface ICourse {
  id: number;
  name: string;
}

export interface IFavourite {
  id: number;
  student_id: number;
  tutor_id: number;
}

export interface ITutorCourse {
  id: number;
  tutor_id: number;
  course_id: number;
  verification_status: VerificationStatus;
  verified_by: number;
}

export interface ITutorWithCourses extends ITutor {
  is_favourite: boolean;
  courses?: ICourseWithVerificationStatus[];
}

export interface ICourseWithVerificationStatus extends ICourse {
  verification_status: VerificationStatus;
}
