class Event < ApplicationRecord
  Event.inheritance_column = nil
  has_many :activities, dependent: :destroy

  has_many :menu_items

  has_one_attached :image_com

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

  def self.current
    current = nil
    Event.all.each do |e|
      return e if DateTime.now > e.start_date && DateTime.now < e.end_date
      current = e if DateTime.now < e.start_date &&
        (current.nil? || e.start_date < current.start_date)
    end
    raise "No current event found" if current.nil?
    current
  end
end
