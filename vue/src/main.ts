/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */


// Plugins
import {registerPlugins} from '@/plugins'
//@ts-ignore
import {registerSW} from 'virtual:pwa-register'

// Components
import App from './App.vue'

// Composables
import {createApp} from 'vue'
// Axios
import axios from 'axios';
import {startOnlineJobs, useOffline} from "@/router/offline";

import {notification_init, saveSubscription} from "@/utils/notification";

const app = createApp(App)

// Register plugins
registerPlugins(app)

axios.defaults.timeout = 5 * 1000; // 5 seconds
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


// window.addEventListener('push-notification', (e: any) => {
//   alert("window")
//   alert(JSON.stringify(e))
// })
// document.addEventListener('push-notification', (e: any) => {
//   alert("document")
//   alert(JSON.stringify(e))
// })

// Mount the app
app.mount('#app')


/**
 axios.get('/version').then(async res => {
 if (localStorage.getItem('version') === res.data.version)
 return
 if (localStorage.getItem('version') === null)
 return localStorage.setItem('version', res.data.version)

 // if (localStorage.getItem('version') !== null)
 //   alert('A new version of the app is available, the app will reload to update it')

 await navigator.serviceWorker.getRegistrations()
 .then(registrations =>
 registrations.forEach(registration =>
 registration.unregister()));
 localStorage.setItem('version', res.data.version)
 window.location.reload()
 }).catch()
 */

const updateSW = registerSW({
  async onNeedRefresh() {
    await updateSW(true)
  }
})


startOnlineJobs()

notification_init().then(saveSubscription)

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
