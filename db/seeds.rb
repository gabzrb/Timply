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

packvert = Pack.create!(title: TITLES[0], category:VERT)
packprio = Pack.create!(title: TITLES[1], category:PRIO)
packsuivie = Pack.create!(title: TITLES[2], category:SUIVIE)
packreco = Pack.create!(title: TITLES[3], category:RECO)

admin = User.create!(name: "Gabriel Zerbib", entreprise: "Timply", address: "4bis rue Benjamin Delessert", email: "gabrielzerbib6@gmail.com", password: "123456", admin: true)

puts "C'est bon c'est fait on peut coder!"
