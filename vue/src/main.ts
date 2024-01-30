/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

import DisableDevtool from 'disable-devtool';


// Plugins
import {registerPlugins} from '@/plugins'

// Components
import App from './App.vue'

// Composables
import {createApp} from 'vue'

const app = createApp(App)

// Register plugins
registerPlugins(app)

// Axios
import axios from 'axios';
import disableDevtool from "disable-devtool";

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
