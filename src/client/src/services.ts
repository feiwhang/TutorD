import { Course } from "./models";
import { useFetch } from "./composables/useFetch";

const baseApiUrl = "http://localhost:5001/api";

const fetchCourses = async (): Promise<Course[]> => {
  const { data, error } = useFetch(`${baseApiUrl}/courses`);

  if (error.value) return [];

  return data.value as Course[];
};

export { fetchCourses };
