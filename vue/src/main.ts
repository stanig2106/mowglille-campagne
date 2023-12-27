/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

import "./registerServiceWorker.js"

// Plugins
import {registerPlugins} from '@/plugins'

// Components
import App from './App.vue'

// Composables
import {createApp} from 'vue'
import router from "@/router";

const app = createApp(App)

// Register plugins
registerPlugins(app)

app.use(router)


// Axios
import axios from 'axios';
import './registerServiceWorker'

axios.interceptors.request.use(config => {

  config.url = `/api${config.url}`;

  config.params = {
    token: localStorage.getItem('token'),
    ...(config.params || {})
  }

  if (process.env.DEV)
    config.baseURL = 'http://localhost:3000';

  return config;
}, error => {
  return Promise.reject(error);
});


// Mount the app
app.mount('#app')
