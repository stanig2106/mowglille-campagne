import {createRouter, createWebHistory} from 'vue-router'
import games from "@/router/games";

const routes = [
  {
    path: '/', component: () => import('../views/Home.vue'),
    meta: {}
  },
  {
    path: '/cla_login', component: () => import('../views/CLALogin.vue'),
    meta: {
      fullpage: true,
    }
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
    path: '/profile', component: () => import('../views/Profile.vue'),
    meta: {
      title: 'Profil',
    }
  },
  {
    path: '/qrcode', component: () => import('../views/QRCode.vue'),
    meta: {
      title: 'QR Code',
    }
  },
  {
    path: '/collection', component: () => import('../views/Collection.vue'),
    meta: {
      title: 'Collection',
    }
  },
  {
    path: '/links', component: () => import('../views/Links.vue'),
    meta: {
      title: 'Liens utiles',
    }
  },

  ...games,


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
