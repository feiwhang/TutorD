import { ref, watchEffect, toValue } from "vue";

export function useFetch(url: any) {
  const data = ref<any>();
  const error = ref<any>();

  watchEffect(async () => {
    // reset state before fetching..
    data.value = null;
    error.value = null;

    // resolve the url value synchronously so it's tracked as a
    // dependency by watchEffect()
    const urlValue = toValue(url);

    try {
      // artificial delay / random error
      await timeout();
      // unref() will return the ref value if it's a ref
      // otherwise the value will be returned as-is
      const res = await fetch(urlValue);
      data.value = await res.json();
    } catch (e) {
      error.value;
    }
  });

  return { data, error };
}

// artificial delay
function timeout() {
  return new Promise<void>((resolve, reject) => {
    setTimeout(() => {
      if (Math.random() > 0.3) {
        resolve();
      } else {
        reject(new Error("Random Error"));
      }
    }, 300);
  });
}
