User.destroy_all
Pack.destroy_all
Order.destroy_all
puts "Je suis le Dieu du Timbre"

TITLES = ["Lettre Verte", "Lettre Prioritaire", "Lettre Suivie", "Recommandés"]
POIDS = ["20g", "100g", "250g", "500g", "3kg"]
INFO_Vert = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odit officiis a placeat, fugiat voluptatibus quos blanditiis consequuntur soluta atque error quis aliquam tenetur.
 Pour toute demande particulière (collecte de vos enveloppes ...) Contactez-nous'
DESCRIPTION_V = "À partir de 0,83€"
DESCRIPTION_P = "À partir de 1€"
DESCRIPTION_S = "À partir de 1,20€"
DESCRIPTION_R = "À partir de 4€"

DELIVERED_V = "Délivré en 2 jours"
DELIVERED_P = "Délivré en 1 jours"
DELIVERED_S = "Délivré en 2 jours"
DELIVERED_R =  "Délivré en 2 jours"

VERT = ["Pack Vert"]
PRIO = ["Pack Prioritaire", "Pack Prioritaire Internationale"]
SUIVIE = ["Pack Suivie", "Pack Suivie Internationale"]
RECO = ["Pack R1", "Pack R2", "Pack R3", "Pack R1 Internationale", "Pack R2 Internationale"]

packvert = Pack.create!(title: TITLES[0], category:VERT, photo:"https://i.ibb.co/Z2Jjz9Y/Screen-Shot-2018-12-18-at-20-22-59.png", infos: INFO_Vert, description:DESCRIPTION_V, delivered:
                        DELIVERED_V )
packprio = Pack.create!(title: TITLES[1], category:PRIO, photo: "https://i.ibb.co/RNMcFqG/Screen-Shot-2018-12-18-at-19-29-54.png",infos: INFO_Vert, description:DESCRIPTION_P, delivered:DELIVERED_P  )
packsuivie = Pack.create!(title: TITLES[2], category:SUIVIE, photo: "https://i.ibb.co/KKLQdXy/Screen-Shot-2018-12-18-at-19-34-33.png",infos: INFO_Vert, description:DESCRIPTION_S, delivered:DELIVERED_S )
packreco = Pack.create!(title: TITLES[3], category:RECO, photo: "https://i.ibb.co/NVnmv8p/Screen-Shot-2018-12-18-at-20-24-37.png",infos: INFO_Vert, description:DESCRIPTION_R, delivered:DELIVERED_R )

admin = User.create!(name: "Gabriel Zerbib", entreprise: "Timply", address: "4bis rue Benjamin Delessert", email: "gabrielzerbib6@gmail.com", password: "123456", admin: true)
admin = User.create!(name: "Ilan Millet", entreprise: "Timply", address: "12 rue Vivienne", email: "ilan.millet@gmail.com", password: "vestige", admin: true)
admin = User.create!(name: "Marc Uzan", entreprise: "Timply", address: "12 rue Vivienne", email: "murcii26@yahoo.fr", password: "vestige", admin: true)

puts "C'est bon c'est fait on peut coder!"
