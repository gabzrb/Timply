User.destroy_all
Pack.destroy_all
puts "Je suis le Dieu du Timbre"

TITLES = ["Lettre Verte", "Lettre Prioritaire", "Lettre Suivie", "Recommandés"]
POIDS = ["20g", "100g", "250g", "500g", "3kg"]
PACKVERT = { "20g": ["0.83", "0.88"], "100g": ["1.67","1.76"], "250g": ["3.34", "3.52"], "500g": ["5","5.28"], "3kg": ["6.7","7.04"]}
PACKPRIO = {"20g": ["1","1.05"], "100g": ["2","2.10"], "250g": ["4","4.20"], "500g": ["6","6.30"], "2kg": ["8","8.40"]}
PRIOINTERNATIONAL = { "20g": ["1.23","1.30"], "100g": ["2.47","2.60"], "250g": ["6.17","6.5"],"500g": ["9.9","10.40"], "2kg": ["17.30","18.20"], "3kg": ["30.4","32.00"]}
PACKSUIVIE = {"20g": ["1.20","1.28"], "100g": ["2","2.16"], "250g": ["3.7","3.92"], "500g": ["5.4","5.68"], "2kg": ["7","7.44"], "3kg": ["7","7.44"]}
SUIVIEINTERNATIONAL = { "20g": ["'4.25","4.50"], "100g": ["5.5","5.80"], "250g": ["9.2","9.70"],"500g": ["12.92","13.60"], "2kg": ["20.33","21.40"], "3kg": ["33.45","35.20"]}
RECOMMANDER1 = { "20g": ["'4","4.18"],"50g": ["4.46","4.70"], "100g": ["5.08","5.35"], "250g": ["6.20","6.50"],"500g": ["7.26","7.65"],"1kg": ["8.3","8.75"], "2kg": ["9.9","10.40"], "3kg": ["11","11.60"]}
RECOMMANDER2 = { "20g": ["'4.65","4.90"],"50g": ["5.20","5.45"], "100g": ["5.75","6.05"], "250g": ["6.88","7.25"],"500g": ["7.88","8.30"],"1kg": ["9","9.50"], "2kg": ["10.5","11.10"], "3kg": ["11.68","12.30"]}
RECOMMANDER3 = { "20g": ["5.75","6.05"],"50g": ["6.17","6.50"], "100g": ["6.74","7.10"], "250g": ["7.93","8.35"],"500g": ["8.88","9.35"],"1kg": ["9","10.55"], "2kg": ["11.6","12.25"], "3kg": ["12.73","13.40"]}
R1INTERNATIONAL =  { "20g": ["5.5","5.80"], "100g": ["6.75","7.10"], "250g": ["10.45","11"],"500g": ["14.15","14.90"],"2kg": ["21.55","22.70"] }
R2INTERNATIONAL =  { "20g": ["6.46","6.80"], "100g": ["7.69","8.10"], "250g": ["11.4","12"], "500g": ["15.1","15.9"],"2kg": ["22.5","23.70"] }

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
