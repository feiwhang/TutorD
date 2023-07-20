export class Repository {
  async get<T>(url: string): Promise<T> {
    return fetch(url).then((res) => res.json());
  }

  async post<T>(url: string, body: any): Promise<T> {
    return fetch(url, {
      method: "POST",
      body: JSON.stringify(body),
      headers: {
        "Content-Type": "application/json",
      },
    }).then((res) => res.json());
  }

  async delete<T>(url: string): Promise<T> {
    return fetch(url, {
      method: "DELETE",
    }).then((res) => res.json());
  }
}
