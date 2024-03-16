export default [
  {
    path: '/staff', component: () => import('../views/staff/Index.vue'),
    meta: {
      title: 'Espace staffeur',
    }
  },
  {
    path: "/staff/planning", component: () => import('../views/staff/Planning.vue'),
    meta: {
      title: "Voir les plannings",
      density: 'compact',
    },
  },
  {
    path: "/staff/manage_planning", component: () => import('../views/staff/ManagePlanning.vue'),
    meta: {
      title: "Gérer les plannings",
    },
  },
  {
    path: "/staff/manage_staff", component: () => import('../views/staff/ManageStaff.vue'),
    meta: {
      title: "Gérer les staffeurs",
    },
  },
  {
    path: "/staff/activity", component: () => import('../views/staff/Activity.vue'),
    meta: {
      title: "Staff Activité en cours",
    },
  },
  {
    path: '/staff/offer', component: () => import('../views/staff/Offer.vue'),
    meta: {
      title: "Donner du miel",
    },
  },
  {
    path: '/staff/manage_score', component: () => import('../views/staff/ManageScore.vue'),
    meta: {
      title: "Gérer les activités",
    },
  },
  {
    path: '/staff/validate_challenge', component: () => import('../views/staff/ValidateChallenge.vue'),
    meta: {
      title: "Valider un défi",
    },
  },
  {
    path: '/staff/manage_challenge', component: () => import('../views/staff/ManageChallenge.vue'),
    meta: {
      title: "Gérer les défis",
    },
  },
  {
    path: '/staff/manage_sound', component: () => import('../views/staff/ManageSound.vue'),
    meta: {
      title: "Gérer les sons",
    },
  },
  {
    path: '/staff/manage_photo', component: () => import('../views/staff/ManagePhoto.vue'),
    meta: {
      title: "Gérer les albums",
    },
  },
  {
    path: '/staff/notify', component: () => import('../views/staff/Notify.vue'),
    meta: {
      title: "Notifier",
    },
  },
  {
    path: '/staff/manage_com', component: () => import('../views/staff/ManageCom.vue'),
    meta: {
      title: "Gérer la com",
    },
  },
  {
    path: '/staff/tombola', component: () => import('../views/staff/Tombola.vue'),
    meta: {
      title: "Tombola",
    },
  }

]
