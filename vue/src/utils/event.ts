export function typeToString(type: string): string {
  return {
    GOU: "Goûter",
    TOR: "Torcho",
    HOT: "Hotlines",
    DEJ: "Déjeuner",
    PDE: "Petit déjeuner",
    SLI: "Soirée à Lille",
    FAP: "Fin d'aprèm",
    DEB: "Débat des prèz",
    DHO: "Dark hotlines",
    BRU: "Brunch",
    APR: "Aprèm",
    TOT: "Torch'tot",
    VOT: "Jour de vote",
    RES: "Résultats"
  }[type] || type
}

export function dayOfWeekToString(day: number): string {
  return {
    0: "Dim.",
    1: "Lun.",
    2: "Mar.",
    3: "Mer.",
    4: "Jeu.",
    5: "Ven.",
    6: "Sam."
  }[day] || "??"
}
