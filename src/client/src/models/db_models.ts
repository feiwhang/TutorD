// models.ts

export interface IStudent {
  student_id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface ITutor {
  tutor_id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface IAdmin {
  admin_id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface ICourse {
  course_id: number;
  name: string;
}

export interface IFavourite {
  favourite_id: number;
  student_id: number;
  tutor_id: number;
}

export interface ITutorCourse {
  tutor_course_id: number;
  tutor_id: number;
  course_id: number;
  verification_status: string;
  verified_by: number;
}
