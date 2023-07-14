export class Repository {
  async get<T>(url: string): Promise<T> {
    return fetch(url).then((res) => res.json());
  }
}
