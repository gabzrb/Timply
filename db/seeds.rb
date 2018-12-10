User.destroy_all
Pack.destroy_all
puts "Je suis le Dieu du Timbre"

CATEGORIES = ["Lettre Verte", "Lettre Prioritaire", "Lettre Suivie", "Personnalisé"]
pack1 = Pack.create!(category: CATEGORIES[0])
pack2 = Pack.create!(category: CATEGORIES[1])
pack3 = Pack.create!(category: CATEGORIES[2])
pack4 = Pack.create!(category: CATEGORIES[3])

admin = User.create!(name: "Gabriel Zerbib", entreprise: "Timply", address: "4bis rue Benjamin Delessert", email: "gabrielzerbib6@gmail.com", password: "123456", admin: true)

puts "C'est bon c'est fait on peut coder!"
