// VITE_API_MODE により呼び出すAPIモジュールを切り替え

const apiMode = import.meta.env.VITE_API_MODE;

let apiClient;

