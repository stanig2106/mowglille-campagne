# Event

Event.create!([
                {
                  internal_id: "2",
                  type: "GOU",
                  name: "Gouter de lancement",
                  # 08/03/2024 à 19h00 au 08/03/2024 à 20h00
                  start_date: DateTime.new(2024, 3, 8, 19, 0, 0),
                  end_date: DateTime.new(2024, 3, 8, 20, 0, 0),
                  location: "Barbecue",
                  description: "TODO description",
                },
                {
                  internal_id: "3",
                  type: "TOR",
                  name: "Temple de la mémoire perdue",
                  # 08/03/2024 à 22h00 au 09/03/2024 à 3h00
                  start_date: DateTime.new(2024, 3, 8, 22, 0, 0),
                  end_date: DateTime.new(2024, 3, 9, 3, 0, 0),
                  location: "Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "4",
                  type: "HOT",
                  name: "Hotlines",
                  # 09/03/2024 à 14h00 au 09/03/2024 à 19h00
                  start_date: DateTime.new(2024, 3, 9, 14, 0, 0),
                  end_date: DateTime.new(2024, 3, 9, 19, 0, 0),
                  location: "Rez / Lille",
                  description: "TODO description",
                },
                {
                  internal_id: "5",
                  type: "DEJ",
                  name: "Déjeuner Flam’s",
                  # 11/03/2024 à 11h30 au 09/03/2024 à 13h30
                  start_date: DateTime.new(2024, 3, 11, 11, 30, 0),
                  end_date: DateTime.new(2024, 3, 11, 13, 30, 0),
                  location: "Centrale / Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "6",
                  type: "PDE",
                  name: "Petit déjeuner 1",
                  # 12/03/2024 à 7h30 au 12/03/2024 à 10h30
                  start_date: DateTime.new(2024, 3, 12, 7, 30, 0),
                  end_date: DateTime.new(2024, 3, 12, 10, 30, 0),
                  location: "Centrale : Couloir des amphi / Rez : bat. AB",
                  description: "TODO description",
                },
                {
                  internal_id: "7",
                  type: "SLI",
                  name: "Soirée Lille",
                  # 12/03/2024 à 20h00 au 13/03/2024 à 0h00
                  start_date: DateTime.new(2024, 3, 12, 20, 0, 0),
                  end_date: DateTime.new(2024, 3, 13, 0, 0, 0),
                  location: "Lille : 2 rue des canonniers",
                  description: "TODO description",
                },
                {
                  internal_id: "8",
                  type: "DEJ",
                  name: "Déjeuner 2",
                  # 13/03/2024 à 11h30 au 13/03/2024 à 13h30
                  start_date: DateTime.new(2024, 3, 13, 11, 30, 0),
                  end_date: DateTime.new(2024, 3, 13, 13, 30, 0),
                  location: "Centrale / Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "9",
                  type: "FAP",
                  name: "Il en faut peu pour être heureux",
                  # 13/03/2024 à 17h00 au 13/03/2024 à 19h00
                  start_date: DateTime.new(2024, 3, 13, 17, 0, 0),
                  end_date: DateTime.new(2024, 3, 13, 19, 0, 0),
                  location: "Synthé",
                  description: "TODO description",
                },
                {
                  internal_id: "DP",
                  type: "DEB",
                  name: "Débat des préz",
                  # 14/03/2024 à 16h00 au 14/03/2024 à 18h00
                  start_date: DateTime.new(2024, 3, 14, 16, 0, 0),
                  end_date: DateTime.new(2024, 3, 14, 18, 0, 0),
                  location: "Amphi",
                  description: "TODO description",
                },
                {
                  internal_id: "10",
                  type: "DHO",
                  name: "Dark Hotline",
                  # 14/03/2024 à 20h00 au 15/03/2024 à 0h00
                  start_date: DateTime.new(2024, 3, 14, 20, 0, 0),
                  end_date: DateTime.new(2024, 3, 15, 0, 0, 0),
                  location: "Rez / Lille",
                  description: "TODO description",
                },
                {
                  internal_id: "11",
                  type: "PDE",
                  name: "Petit déjeuner 2",
                  # 15/03/2024 à 7h30 au 15/03/2024 à 10h30
                  start_date: DateTime.new(2024, 3, 15, 7, 30, 0),
                  end_date: DateTime.new(2024, 3, 15, 10, 30, 0),
                  location: "Centrale : Couloir des amphi / Rez : bat. AB",
                  description: "TODO description",
                },
                {
                  internal_id: "12",
                  type: "BRU",
                  name: "Gueule de boa",
                  # 16/03/2024 à 11h30 au 16/03/2024 à 13h30
                  start_date: DateTime.new(2024, 3, 16, 11, 30, 0),
                  end_date: DateTime.new(2024, 3, 16, 13, 30, 0),
                  location: "Barbecue / Rez",
                  description: "TODO description",
                },
                {
                  internal_id: "13",
                  type: "APR",
                  name: "L’ivre de la jungle",
                  # 16/03/2024 à 14h00 au 16/03/2024 à 19h00
                  start_date: DateTime.new(2024, 3, 16, 14, 0, 0),
                  end_date: DateTime.new(2024, 3, 16, 19, 0, 0),
                  location: "Synthé / Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "14",
                  type: "TOT", # TORCHTOT (20h00h)
                  name: "Dans la jungle terrible jungle, les campagnes sont mortes ce soir",
                  # 16/03/2024 à 20h00 au 17/03/2024 à 00h00
                  start_date: DateTime.new(2024, 3, 16, 20, 0, 0),
                  end_date: DateTime.new(2024, 3, 17, 0, 0, 0),
                  location: "Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "15",
                  type: "VOT",
                  name: "Jours de vote",
                  # 17/03/2024 à 7h00 au 17/03/2024 à 18h00
                  start_date: DateTime.new(2024, 3, 17, 7, 0, 0),
                  end_date: DateTime.new(2024, 3, 17, 18, 0, 0),
                  location: "Site CLA",
                  description: "TODO description",
                },
                {
                  internal_id: "16",
                  type: "RES",
                  name: "Résultats",
                  # 17/03/2024 à 20h00 au 17/03/2024 à 22h00
                  start_date: DateTime.new(2024, 3, 17, 20, 0, 0),
                  end_date: DateTime.new(2024, 3, 17, 22, 0, 0),
                  location: "Foyer",
                  description: "TODO description",
                }
              ])
