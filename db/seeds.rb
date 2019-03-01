Participation.destroy_all
Event.destroy_all
User.destroy_all

puts 'Start'

u1 = User.create!(email: 'kenza@centrall.com', username: 'kenza', password: '123soleil')
u2 = User.create!(email: 'xeniia@centrall.com', username: 'xeniia', password: '123soleil')
u3 = User.create!(email: 'nicolas@centrall.com', username: 'nicolas', password: '123soleil')
u4 = User.create!(email: 'benoit@centrall.com', username: 'benoit', password: '123soleil')

date = Date.tomorrow

e2 = Event.create!(name: 'Meeting au resto', start_at: date, kind: 1, user: u2)

e1 = Event.create!(name: 'Meeting Onyrik', start_at: date, kind: 0, user: u4)

buffoni = Place.create!(event: e1, google_id: "a1234", name: "Buffoni", address: "12 Rue Fancul", rating: "3.9")
sweet = Place.create!(event: e1, google_id: "b1234", name: "Sweet Bastard", address: "20 Allée Shit", rating: "4.5")
connard = Place.create!(event: e1, google_id: "c1234", name: "Chez Connard", address: "48 Impasse Naze", rating: "4.1")

Participation.create!(user: u4, event: e1, place: buffoni)
Participation.create!(user: u1, event: e1, place: sweet)
Participation.create!(user: u3, event: e1, place: buffoni)
Participation.create!(user: u2, event: e1, place: connard)

e3 = Event.create!(name: 'Afterwork', start_at: date, kind: 0, user: u2, place: english)

italian = Place.create!(event: e3, google_id: "a1234", name: "Buffoni", address: "12 Rue Fancul", rating: "3.9")
english = Place.create!(event: e3, google_id: "b1234", name: "Sweet Bastard", address: "2 Cours d'Alsace-et-Lorraine, 33000 Bordeaux
", rating: "4.5")
french = Place.create!(event: e3, google_id: "c1234", name: "Chez Connard", address: "48 Impasse Naze", rating: "4.1")

Participation.create!(user: u1, event: e3, place: english)
Participation.create!(user: u2, event: e3, place: english)
Participation.create!(user: u3, event: e3, place: french)
Participation.create!(user: u4, event: e3, place: italian)

puts 'End'
