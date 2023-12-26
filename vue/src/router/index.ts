import {createRouter, createWebHistory} from 'vue-router'

const routes = [
  {
    path: '/', component: () => import('../views/Home.vue'),
    meta: {}
  },
  {
    path: '/login', component: () => import('../views/Login.vue'),
    meta: {
      fullpage: true,
    }
  },
  {
    path: '/scoreboard', component: () => import('../views/Scoreboard.vue'),
    meta: {
      title: 'Classement',
    }
  },
  {
    path: '/score_details', component: () => import('../views/ScoreDetails.vue'),
    meta: {
      title: 'Historique des scores',
    }
  },
  {
    path: '/qrcode', component: () => import('../views/QRCode.vue'),
    meta: {
      title: 'QR Code',
    }
  },
  {
    path: '/links', component: () => import('../views/Links.vue'),
    meta: {
      title: 'Liens utiles',
    }
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
