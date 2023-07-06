// models.ts

export interface Student {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface Tutor {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface Course {
  id: number;
  name: string;
}

export interface Favourite {
  id: number;
  student_id: number;
  tutor_id: number;
}

export interface TutorCourse {
  id: number;
  tutor_id: number;
  course_id: number;
  verification_status: string;
  verified_by: number;
}

export interface Admin {
  id: number;
  username: string;
}
