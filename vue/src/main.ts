/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'
import router from "@/router";

const app = createApp(App)

registerPlugins(app)

app.use(router)
app.mount('#app')


import axios from 'axios';
import './registerServiceWorker'

axios.interceptors.request.use(config => {
  const csrfToken = (() => {
    const cookies = document.cookie.split(';');
    for (let cookie of cookies) {
      let [key, value] = cookie.split('=');
      if (key.trim() === 'csrf_token') {
        return value.trim();
      }
    }
    return null;
  })();

  if (csrfToken)
    config.headers['X-CSRF-Token'] = csrfToken;

  config.url = `/api${config.url}`;

  if (process.env.DEV)
    config.baseURL = 'http://localhost:3000';

  return config;
}, error => {
  return Promise.reject(error);
});
