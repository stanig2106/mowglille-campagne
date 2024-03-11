import {createRouter, createWebHistory} from 'vue-router'
import games from "@/router/games";
import staff from "@/router/staff";

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
    path: '/menu', component: () => import('../views/Menu.vue'),
    meta: {
      title: 'Menu du jour',
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
  {
    path: '/challenges', component: () => import('../views/Challenges.vue'),
    meta: {
      title: 'Défis',
    }
  },
  {
    path: '/trombi', component: () => import('../views/Trombi.vue'),
    meta: {
      title: 'Trombi',
    }
  },
  {
    path: '/program', component: () => import('../views/Program.vue'),
    meta: {
      title: 'Programme',
    }
  },
  {
    path: '/planning', component: () => import('../views/Planning.vue'),
    meta: {
      title: 'Planning',
    }
  },
  {
    path: '/event_info', component: () => import('../views/EventInfo.vue'),
    meta: {
      title: 'Informations',
    }
  },
  {
    path: '/fil_rouge', component: () => import('../views/FilRouge.vue'),
    meta: {
      title: 'Fil rouge',
    }
  },
  {
    path: '/activities', component: () => import('../views/Activities.vue'),
    meta: {
      title: 'Activités',
    }
  },
  ...games,
  ...staff,


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
