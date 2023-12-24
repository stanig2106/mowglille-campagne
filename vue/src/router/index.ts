import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  { path: '/', component: () => import('../views/Home.vue') },
  { path: '/login', component: () => import('../views/Login.vue') },
  { path: '/scoreboard', component: () => import('../views/Scoreboard.vue') },
  { path: '/score_details', component: () => import('../views/ScoreDetails.vue') },
  { path: '/qrcode', component: () => import('../views/QRCode.vue') },

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
