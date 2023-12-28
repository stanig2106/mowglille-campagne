export default [
  {
    path: '/games/human_benchmark', component: () => import('../views/games/humanBenchmark/Index.vue'),
    meta: {
      title: 'Human Benchmark',
    }
  },
  {
    path: '/games/human_benchmark/classement', component: () => import('../views/games/humanBenchmark/Classement.vue'),
    meta: {
      title: 'Human Benchmark',
    }
  },
  /*
  {
    path: '/games/human_benchmark/play', component: () => import('../views/games/humanBenchmark/Play.vue'),
    meta: {
      title: 'Human Benchmark',
      density: 'compact',
    }
  }
   */
]
