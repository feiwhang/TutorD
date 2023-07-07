// models.ts

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
  verification_status: string;
  verified_by: number;
}

export interface IAdmin {
  id: number;
  username: string;
}
