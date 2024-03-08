# Event

Event.create!([
                {
                  internal_id: "2",
                  type: "GOU",
                  name: "Goûter de lancement",
                  # 08/03/2024 à 19h00 au 08/03/2024 à 20h00
                  start_date: DateTime.new(2024, 3, 8, 19, 0, 0),
                  end_date: DateTime.new(2024, 3, 8, 20, 0, 0),
                  location: "Barbecue",
                  description: "TODO description",
                },
                {
                  internal_id: "3",
                  type: "TOR",
                  name: "Ça va commencer ici...",
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
                  name: "Tout feu tout flams",
                  # 11/03/2024 à 11h30 au 09/03/2024 à 13h30
                  start_date: DateTime.new(2024, 3, 11, 11, 30, 0),
                  end_date: DateTime.new(2024, 3, 11, 13, 30, 0),
                  location: "Centrale / Foyer",
                  description: "TODO description",
                },
                {
                  internal_id: "6",
                  type: "PDE",
                  name: "Il fait beau, il fait jour, c'est le moment pour...",
                  # 12/03/2024 à 7h30 au 12/03/2024 à 10h30
                  start_date: DateTime.new(2024, 3, 12, 7, 30, 0),
                  end_date: DateTime.new(2024, 3, 12, 10, 30, 0),
                  location: "Centrale : Couloir des amphi / Rez : bat. AB",
                  description: "TODO description",
                },
                {
                  internal_id: "7",
                  type: "SLI",
                  name: "Soirée à Lille",
                  # 12/03/2024 à 20h00 au 13/03/2024 à 0h00
                  start_date: DateTime.new(2024, 3, 12, 20, 0, 0),
                  end_date: DateTime.new(2024, 3, 13, 0, 0, 0),
                  location: "Lille : 2 rue des canonniers",
                  description: "TODO description",
                },
                {
                  internal_id: "8",
                  type: "DEJ",
                  name: "Une fail de Baloup",
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
                  name: "Miam miam miam, trop bon, crunch crunch crunch",
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
                  name: "Dans la jungle terrible jungle, les campagnes sont mortes",
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
              ]) unless Event.count != 0

{
  "2": [
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Gaufres",
      "vg": true,
      "type": "DES",
      "src": "gauffres.png",
      desc: "Rien de plus réconfortant qu'une gaufre, viens essayer une de nos gaufres au sucre ou fais le gourmand et prends en une au Nutella",
    }
  ],
  "3": [
    {
      "name": "Plat secret",
      "vg": false,
      "type": "PLA",
      "src": "plat_secret.png",
    }
  ],
  "4": [
    {
      "name": "Croque Monsieur",
      "vg": false,
      "type": "CLA",
      "src": "croque_monsieur.png",
      desc: "Un petite gourmandise qui a fait fureur durant le WEL. Attention, ça devient rapidement compliqué de s'arrêter"
    },
    {
      "name": "Fajitas",
      "vg": false,
      "type": "PLA",
      "src": "fajitas.png",
      desc: "Le saviez-vous ? Les Fajitas sont en fait originaires du Texas"
    },
    {
      "name": "Pizzas",
      "vg": false,
      "type": "PLA",
      "src": "pizzas.png",
      desc: "La pizza, c'est la vie. Viens déguster une de nos pizzas, tu ne seras pas déçu"
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Gâteau à l'orange",
      "vg": true,
      "type": "DES",
      "src": "gâteau_a_lorange.png",
      desc: "Un gâteau à l'orange, c'est toujours un plaisir"
    }
  ],
  "8": [
    {
      "name": "Pan Con Tomate",
      "vg": true,
      "type": "ENTREE",
      "src": "garlic_bread.png",
      desc: "Le pan con tomate, également connu sous le nom de \"pa amb tomàquet\" en catalan, est une spécialité culinaire traditionnelle originaire de Catalogne, une région située dans le nord-est de l'Espagne. Cependant, il est également populaire dans d'autres régions d'Espagne, comme les îles Baléares et la région de Valence",
    },
    {
      "name": "Croque-Monsieur",
      "vg": false,
      "type": "CLA",
      "src": "croque-monsieur.png",
      desc: "Un petite gourmandise qui a fait fureur durant le WEL. Attention, ça devient rapidement compliqué de s'arrêter"
    },
    {
      "name": "Lasagnes",
      "vg": true,
      "type": "PLA",
      "src": "lasagnes.png",
      desc: "Si jamais les croque-monsieur ne vous font pas envie, voilà un beau mélange de légumes pour vous"
    },
    {
      "name": "Brownie",
      "vg": true,
      "type": "DES",
      "src": "brownie.png",
      desc: "Un bon fudge brownie à l'anglaise qui a autant un goût de reviens-y que de \"il faudrait que je fasse un régime moi\""
    },
    {
      "name": "Sirops à l'eau",
      "vg": true,
      "type": "BOI",
      "src": "sirops_a_leau.png"
    }
  ],
  "6": [
    {
      "name": "Panini Tomate Mozzarella",
      "vg": true,
      "type": "ENTREE",
      "src": "avocado_toast.png",
      desc: "Un basique, comment le refuser ?"
    },
    {
      "name": "Gâteau au Yaourt",
      "vg": true,
      "type": "DES",
      "src": "gateau_au_yaourt.png",
      desc: "Une vraie recette de grand-mère, à manger avec du Nutella ou bien nature"
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Pancakes",
      "vg": true,
      "type": "DES",
      "src": "pancakes.png",
      desc: "Nouveauté il faut croire... Venez les déguster avec du sirop d'érable ou du Nutella"
    },
    {
      "name": "Gaufres",
      "vg": true,
      "type": "DES",
      "src": "gauffres.png",
      desc: "Rien de plus réconfortant qu'une gaufre, viens essayer une de nos gaufres au sucre ou fais le gourmand et prends en une au Nutella"
    }
  ],
  "5": [
    {
      "name": "Flam's",
      "vg": false,
      "type": "PLA",
      "src": "flams.png"
    },
    {
      "name": "Sirops à l'eau",
      "vg": true,
      "type": "BOI",
      "src": "sirops_a_leau.png"
    }
  ],
  "9": [
    {
      "name": "Roulé Saucisse",
      "vg": false,
      "type": "ENTREE",
      "src": "roulé_saucisse.png",
      desc: "Un petit délice, c'est difficile de n'en manger qu'un"
    },
    {
      "name": "Burger Tenders",
      "vg": false,
      "type": "PLA",
      "src": "burger_tenders.png",
      desc: "Petite inspiration japonaise, inspiration Tonkatsu plus précisément. Notre Burger Tenders façon Tonkatsu avec son chou et sa petite sauce sucrée en a surpris plus d'un."
    },
    {
      "name": "Frites",
      "vg": true,
      "type": "PLA",
      "src": "frite.png",
      desc: "À faire rougir celles de Triolo"
    },
    {
      "name": "Cake Choco banane",
      "vg": true,
      "type": "DES",
      "src": "cake_choco_banane.png",
      desc: "Mélange de saveurs qui a fait ses preuves"
    },
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Chocolat Chaud",
      "vg": true,
      "type": "BOI",
      "src": "chocolat_chaud.png",
      desc: "Un bon chocolat chaud pour se réchauffer"
    },
    {
      "name": "Chocolat Chaud Bailey's",
      "vg": true,
      "type": "BOI",
      "src": "chocolat_chaud.png",
      desc: "Avec un peu de Bailey's pour les plus téméraires"
    }
  ],
  "10": [
    {
      "name": "Croque Monsieur",
      "vg": false,
      "type": "CLA",
      "src": "croque_monsieur.png",
      desc: "Un petite gourmandise qui a fait fureur durant le WEL. Attention, ça devient rapidement compliqué de s'arrêter"
    },
    {
      "name": "Tarte à la tomate",
      "vg": true,
      "type": "PLA",
      "src": "tarte_a_la_tomate.png",
      desc: "Une bonne recette un peu plus healthy que les autres. Pour changer..."
    },
    {
      "name": "Pizzas",
      "vg": false,
      "type": "PLA",
      "src": "pizzas.png",
      desc: "La pizza, c'est la vie. Viens déguster une de nos pizzas, tu ne seras pas déçu"
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Fondant au Chocolat",
      "vg": true,
      "type": "DES",
      "src": "fondant_au_chocolat.png",
      desc: "S/O Centr'altitude pour la recette"
    }
  ],
  "11": [
    {
      "name": "Avocado Toast",
      "vg": true,
      "type": "PLA",
      "src": "avocado_toast.png",
      desc: "Un basique, comment le refuser ?"
    },
    {
      "name": "Pancakes",
      "vg": true,
      "type": "DES",
      "src": "pancakes.png",
      desc: "Nouveauté il faut croire... Venez les déguster avec du sirop d'érable ou du Nutella"
    },
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Gâteau au Yaourt",
      "vg": true,
      "type": "DES",
      "src": "gateau_au_yaourt.png",
      desc: "Une vraie recette de grand-mère, à manger avec du Nutella ou bien nature"
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Café",
      "vg": true,
      "type": "BOI",
      "src": "café.png",
      desc: "Un bon café pour bien commencer la journée"
    },
    {
      "name": "Chocolat chaud",
      "vg": true,
      "type": "BOI",
      "src": "chocolat_chaud.png",
      desc: "Un bon chocolat chaud pour se réchauffer"
    }
  ],
  "13": [
    {
      "name": "Briques",
      "vg": true,
      "type": "ENTREE",
      "src": "briques_vg.png",
      desc: "Le brik (ou brick), appelé aussi bourek, est une sorte de chausson originaire du Maghreb, préparé à partir d'une feuille de pâte très fine portant le même nom, à base de farine et de semoule de blé, façonnée généralement en un triangle fourré"
    },
    {
      "name": "Tartes Soleil Pesto Tomate",
      "vg": true,
      "type": "PLA",
      "src": "tartes_soleil_pesto_tomate.png",
      desc: "Qui n'aime pas le Pesto ?"
    },
    {
      "name": "Crêpes",
      "vg": true,
      "type": "DES",
      "src": "crepes.png",
      desc: "Le classique ! La bonne crêpe tout droit sortie de la jungle, viens la déguster avec du sucre, du Nutella ou encore de la confiture."
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Chocolat chaud",
      "vg": true,
      "type": "BOI",
      "src": "chocolat_chaud.png",
      desc: "Un bon chocolat chaud pour se réchauffer"
    }
  ],
  "14": [
    {
      "name": "Kebab et Frites",
      "vg": false,
      "type": "CLA",
      "src": "kebab_et_frites.png",
      desc: "Comment ne pas finir les campagnes avec ce plat, venez déguster nos frites et kebabs maison avec votre compo. Faites attention au défis flash ;)"
    },
    {
      "name": "Cookies",
      "vg": true,
      "type": "DES",
      "src": "cookies.png",
      desc: "À la fois Puffy et gourmands, difficile de n'en manger qu'un..."
    },
    {
      "name": "Fuze Tea",
      "vg": true,
      "type": "BOI",
      "src": "fuze_tea.png",
      desc: "Vous le connaissez, il est là pour rester. N'hésitez pas à solliciter nos staffeurs dès que vous avez une petite soif et nous nous ferons un plaisir de vous servir du Fuze Tea."
    }
  ]
}.each do |event_id, items|
  items.each do |item|
    MenuItem.create!(
      event: Event.find_by(internal_id: event_id),
      name: item[:name],
      vg: item[:vg],
      type: item[:type],
      src: item[:src],
      description: item[:desc]
    )
  end
end unless MenuItem.count != 0

CollectionPiece.create!([
                          *[1, 2, 3, 4, 5, 8, 9, 12, 13, 16, 17, 18, 19, 20].map { { number: _1, rarity: "RARE" } },
                          *[6, 7, 14, 15].map { { number: _1, rarity: "EPIC" } },
                          *[10, 11].map { { number: _1, rarity: "LEGENDARY" } }
                        ]) unless CollectionPiece.count != 0

if ClaInfo.find_by(username: "guest.guest").nil?
  cla_info = ClaInfo.new
  cla_info.username = "guest.guest"
  cla_info.school_email = "guest"
  cla_info.first_name = "guest"
  cla_info.last_name = "guest"
  cla_info.cursus = "guest"
  cla_info.promo = "guest"
  cla_info.save!
  user = User.new
  user.cla_info = cla_info
  user.token = "guest"
  user.public_token = "guest"
  user.notification_preferences = %w[EVENTS GAMES CUSTOM CHALLENGES]
  user.save!
end


