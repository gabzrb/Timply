User.destroy_all
Pack.destroy_all
Order.destroy_all
puts "Je suis le Dieu du Timbre"

TITLES = ["Lettre Verte", "Lettre Prioritaire", "Lettre Suivie", "Recommandés"]
POIDS = ["20g", "50g", "100g", "250g", "500g", "1kg", "2kg", "3kg"]
INFO_Vert = "La lettre verte est la plus économique et met entre 2 et 3 jours à arriver au destinataire. Le délai suite à votre commande varie en fonction de votre demande et est de maximum une semaine.
 Pour toute demande particulière (collecte de vos enveloppes ...), Contactez-nous."
INFO_Prio = "La lettre prioritaire vous permet d'envoyer un courrier urgent en moins de 24h. Le délai suite à votre commande varie en fonction de votre demande et est de maximum une semaine.
 Pour toute demande particulière (collecte de vos enveloppes ...), Contactez-nous."
INFO_Suivie = "La lettre suivie vous permet de suivre l'acheminement et la distribution de vos envois importants, documents ou petits objets en 48h. Le délai suite à votre commande varie en fonction de votre demande et est de maximum une semaine.
 Pour toute demande particulière (collecte de vos enveloppes ...), Contactez-nous."
INFO_Recomandé = "La lettre recomandée permettant à l'expéditeur d'un courrier de recevoir la preuve de sa bonne réception, signée par le récipiendaire. Le délai suite à votre commande varie en fonction de votre demande et est de maximum une semaine.
 Pour toute demande particulière (collecte de vos enveloppes ...), Contactez-nous."
DESCRIPTION_V = "À partir de 0,83€"
DESCRIPTION_P = "À partir de 1€"
DESCRIPTION_S = "À partir de 1,20€"
DESCRIPTION_R = "À partir de 4€"

DELIVERED_V = "Délivré en 2 jours"
DELIVERED_P = "Délivré en 1 jours"
DELIVERED_S = "Délivré en 2 jours"
DELIVERED_R =  "Délivré en 2 jours"

VERT = ["Lettre Verte"]
PRIO = ["Lettre Prioritaire", "Lettre Prioritaire Internationale"]
SUIVIE = ["Lettre Suivie"]
RECO = ["Recommandée R1", "Recommandée R2", "Recommandée R3", "Recommandée R1 Internationale", "Recommandée R2 Internationale"]

packvert = Pack.create!(title: TITLES[0], category:VERT, photo:"https://i.ibb.co/RNkY033/Screen-Shot-2019-03-20-at-11-13-14.png", infos: INFO_Vert, description:DESCRIPTION_V, delivered:
                        DELIVERED_V )
packprio = Pack.create!(title: TITLES[1], category:PRIO, photo: "https://i.ibb.co/121jzR5/Screen-Shot-2019-03-20-at-11-19-14.png",infos: INFO_Prio, description:DESCRIPTION_P, delivered:DELIVERED_P  )
packsuivie = Pack.create!(title: TITLES[2], category:SUIVIE, photo: "https://i.ibb.co/ZV4qWd1/Screen-Shot-2019-03-20-at-11-17-56.png",infos: INFO_Suivie, description:DESCRIPTION_S, delivered:DELIVERED_S )
packreco = Pack.create!(title: TITLES[3], category:RECO, photo: "https://i.ibb.co/v1Y8RQ4/Screen-Shot-2019-03-20-at-11-20-15.png",infos: INFO_Recomandé, description:DESCRIPTION_R, delivered:DELIVERED_R )

admin = User.create!(name: "Gabriel Zerbib", entreprise: "Timply", address: "4bis rue Benjamin Delessert", email: "gabrielzerbib6@gmail.com", password: "123456", admin: true)
admin = User.create!(name: "Ilan Millet", entreprise: "Timply", address: "12 rue Vivienne", email: "ilan.millet@gmail.com", password: "vestige", admin: true)
admin = User.create!(name: "Marc Uzan", entreprise: "Timply", address: "12 rue Vivienne", email: "murcii26@yahoo.fr", password: "vestige", admin: true)

puts "C'est bon c'est fait on peut coder!"
