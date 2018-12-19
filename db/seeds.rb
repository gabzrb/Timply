User.destroy_all
Pack.destroy_all
Order.destroy_all
puts "Je suis le Dieu du Timbre"

TITLES = ["Lettre Verte", "Lettre Prioritaire", "Lettre Suivie", "Recommandés"]
POIDS = ["20g", "100g", "250g", "500g", "3kg"]

VERT = ["Pack Vert"]
PRIO = ["Pack Prioritaire", "Pack Prioritaire Internationale"]
SUIVIE = ["Pack Suivie", "Pack Suivie Internationale"]
RECO = ["Pack R1", "Pack R2", "Pack R3", "Pack R1 Internationale", "Pack R2 Internationale"]

packvert = Pack.create!(title: TITLES[0], category:VERT, photo:"https://i.ibb.co/Z2Jjz9Y/Screen-Shot-2018-12-18-at-20-22-59.png"  )
packprio = Pack.create!(title: TITLES[1], category:PRIO, photo: "https://i.ibb.co/RNMcFqG/Screen-Shot-2018-12-18-at-19-29-54.png"  )
packsuivie = Pack.create!(title: TITLES[2], category:SUIVIE, photo: "https://i.ibb.co/KKLQdXy/Screen-Shot-2018-12-18-at-19-34-33.png" )
packreco = Pack.create!(title: TITLES[3], category:RECO, photo: "https://i.ibb.co/NVnmv8p/Screen-Shot-2018-12-18-at-20-24-37.png" )

admin = User.create!(name: "Gabriel Zerbib", entreprise: "Timply", address: "4bis rue Benjamin Delessert", email: "gabrielzerbib6@gmail.com", password: "123456", admin: true)

puts "C'est bon c'est fait on peut coder!"
