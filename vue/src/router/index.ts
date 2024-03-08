import {createRouter, createWebHistory} from 'vue-router'

const routes = [
  {
    path: '/', component: () => import('../views/Home.vue'),
    meta: {}
  },
  {
    path: '/privacy', component: () => import('../views/Privacy.vue'),
  },
  {
    path: '/legal', component: () => import('../views/Legal.vue'),
  },
  {
    path: '/qr/bache', component: () => import('../views/QR/Bache.vue'),
  },
  // Fallback to home
  {
    path: '/:pathMatch(.*)*',
    redirect: '/',
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
