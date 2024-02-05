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
import {createApp, inject} from 'vue'

const app = createApp(App)

// Register plugins
registerPlugins(app)

// Axios
import axios from 'axios';
import disableDevtool from "disable-devtool";
import {startOnlineJobs, useOffline} from "@/router/offline";

axios.interceptors.request.use(config => {

  config.url = `/api${config.url}`;

  config.params = {
    token: localStorage.getItem('token'),
    ...(config.params || {})
  }

  if (process.env.DEV)
    config.baseURL = 'http://localhost:3000';

  config.timeout = 5 * 1000; // 5 seconds

  return config;
}, error => {
  return Promise.reject(error);
});

axios.interceptors.response.use(response => {
  useOffline().updateOffline(false)
  return response;
}, error => {
  if (error.code === 'ECONNABORTED' || error.code === 'ERR_NETWORK')
    useOffline().updateOffline(true)
  else
    useOffline().updateOffline(false)
  return Promise.reject(error);
});

startOnlineJobs()

// Mount the app
app.mount('#app')


axios.get('/version').then(res => {
  if (localStorage.getItem('version') === res.data.version)
    return

  if (localStorage.getItem('version') !== null)
    alert('A new version of the app is available, the app will reload to update it')

  navigator.serviceWorker.getRegistrations()
    .then(registrations =>
      registrations.forEach(registration =>
        registration.unregister()));
  localStorage.setItem('version', res.data.version)
  window.location.reload()
}).catch()


/*
disableDevtool({
  ignore: () => {
    return window.location.href.includes('localhost')
  },
  disableMenu: true,
  url: 'https://mowglille.fr',
  ondevtoolopen(type, next) {
    axios.post('/devtool', {type}).then(() => next()).catch(() => next())
  },
  md5: 'b07ced62f40a7559f6bdc8150ccfa3eb',
  tkName: 'devtool',
})
*/
