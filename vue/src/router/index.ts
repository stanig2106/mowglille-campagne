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
    path: '/chat', component: () => import('../views/Chat.vue'),
    meta: {
      title: 'Chat',
      density: 'compact',
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

router.beforeEach((to, from, next) => {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(registrations => {
      registrations.forEach(async registration => {
        await registration.update();

        registration.addEventListener('updatefound', () => {
          const installingWorker = registration.installing;
          console.log('A new service worker is being installed:', installingWorker);
          if (installingWorker) {
            installingWorker.addEventListener('statechange', () => {
              if (installingWorker.state === 'installed' && navigator.serviceWorker.controller) {
                window.location.reload();
              }
            });
          }
        });
      });
    });
  }

  next();
});


export default router
