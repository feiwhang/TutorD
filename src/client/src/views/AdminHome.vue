<script setup lang="ts">
import { ref } from "vue";
import { VerificationStatus } from "../models/enums";
import { Repository } from "../repositories";
import { baseApiUrl } from "../const";
import { useUserStore } from "../store/user";
import { useRouter } from "vue-router";

interface IAdminTableRow {
  tutor_id: number;
  tutor_name: string;
  tutor_email: string;
  course_id: number;
  course_name: string;
  verification_status: VerificationStatus;
  verified_by: number;
}
const userStore = useUserStore();
const router = useRouter();
const adminTableRows = ref<IAdminTableRow[]>([]);

const showOnlyPending = ref(false);

const repo = new Repository();

repo.get(`${baseApiUrl}/admin/tutors/courses`).then((res) => {
  adminTableRows.value = res as IAdminTableRow[];
});

const onVerificationStatusChange = (
  tutor_id: number,
  course_id: number,
  event: Event
) => {
  repo
    .put(
      `${baseApiUrl}/admin/${userStore.user?.id}/tutors/${tutor_id}/courses/${course_id}`,
      {
        status: (event.target as HTMLSelectElement)?.value,
      }
    )
    .then((res: any) => {
      if (!res.error) router.go(0);
      else alert(res.error);
    })
    .catch((err) => {
      alert(err.message);
    });
};
</script>
<template>
  <div>
    <div class="container mx-auto p-8">
      <div class="flex justify-between items-center">
        <h1 class="text-3xl font-bold mb-8">Welcome!, ADMIN</h1>
        <div class="flex items-center justify-center">
          <input
            v-model="showOnlyPending"
            id="checked-checkbox"
            type="checkbox"
            value=""
            class="w-6 h-6 text-blue-600 bg-gray-900 border-gray-200 rounded focus:ring-blue-500"
          />
          <label
            for="checked-checkbox"
            class="ml-2 text-xl font-xl text-gray-700"
            >Show only pending</label
          >
        </div>
      </div>
      <table class="table-auto text-xl border border-black">
        <thead class="border-black bg-gray-100">
          <tr class="border">
            <th>tutor_id</th>
            <th>tutor_name</th>
            <th>tutor_email</th>
            <th>course_id</th>
            <th>course_name</th>
            <th>verification_status</th>
            <th>verified_by</th>
          </tr>
        </thead>

        <tr
          v-for="row in adminTableRows.filter(
            (row) =>
              !showOnlyPending ||
              row.verification_status === VerificationStatus.Pending
          )"
          class="border border-black text-center"
        >
          <td>{{ row.tutor_id }}</td>
          <td>{{ row.tutor_name }}</td>
          <td>{{ row.tutor_email }}</td>
          <td>{{ row.course_id }}</td>
          <td>{{ row.course_name }}</td>
          <td>
            <font-awesome-icon
              :icon="`fa-solid ${
                row.verification_status === VerificationStatus.Verified
                  ? 'fa-check-circle'
                  : row.verification_status === VerificationStatus.Pending
                  ? 'fa-clock'
                  : 'fa-cancel'
              }`"
              :color="`${
                row.verification_status === VerificationStatus.Verified
                  ? 'green'
                  : row.verification_status === VerificationStatus.Pending
                  ? 'gray'
                  : 'red'
              }`"
            />
            <select
              name="verification_status"
              @change="
                onVerificationStatusChange(row.tutor_id, row.course_id, $event)
              "
            >
              <option
                v-for="status in [
                  VerificationStatus.Verified,
                  VerificationStatus.Pending,
                  VerificationStatus.Unverified,
                ]"
                :selected="status === row.verification_status"
              >
                {{ status }}
              </option>
            </select>
          </td>
          <td>{{ row.verified_by }}</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<style></style>
