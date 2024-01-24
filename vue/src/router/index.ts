import {createRouter, createWebHistory} from 'vue-router'

const routes = [
  {
    path: '/', component: () => import('../views/Home.vue'),
    meta: {}
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
