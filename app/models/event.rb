class Event < ApplicationRecord
  Event.inheritance_column = nil
  has_many :activities, dependent: :destroy

  def type_as_s
    {
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
    }[type.to_sym] || type
  end
end
