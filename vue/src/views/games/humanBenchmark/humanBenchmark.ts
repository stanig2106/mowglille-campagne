export const games = [
  "reaction_time",
  "chimp_test",
  "sequence_memory",
  "aim_trainer",
  "number_memory",
  "verbal_memory",
  "visual_memory",
] as const;
export type Game = typeof games[number];

export const gameNames = {
  reaction_time: "Temps de réaction",
  chimp_test: "Test de chimpanzé",
  sequence_memory: "Mémoire de séquence",
  aim_trainer: "Entraînement de visée",
  number_memory: "Mémoire de nombres",
  verbal_memory: "Mémoire verbale",
  visual_memory: "Mémoire visuelle",
} as const;
