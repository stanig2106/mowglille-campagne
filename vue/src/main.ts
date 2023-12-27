/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

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


document.addEventListener("load", async () => {
  axios.get('/version').then(res => {
    if (localStorage.getItem('version') === res.data.version)
      return

    alert('A new version of the app is available, the page will reload to update it')

    navigator.serviceWorker.getRegistrations()
      .then(registrations =>
        registrations.forEach(registration =>
          registration.unregister()));
    localStorage.setItem('version', res.data.version)
    window.location.reload()
  }).catch()
})
