# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"
require "date"

puts "cleaning database"
User.destroy_all
Match.destroy_all
Message.destroy_all
BlockedUser.destroy_all

puts "creating Jean-Eudes.BG@gmail.com and azerty login"
age = DateTime.now - 25.years
user_jebg = User.create!(email: "Jean-Eudes.BG@gmail.com",
             password: "azerty",
             first_name: "Jean-Eudes",
             last_name: "BG",
             birthdate: age,
             description: "Salut Biloute, moi c'est Jean-Eude BG, le BG de Paris 17. J'ai #{DateTime.now.year - age.year} ans. L'aprem c'est ricard devant Sardou. Dans la vie j'aime pas les débats: y'a pas à tortiller du cul pour chier droit.",
             gender: "M",
             address: "16 villa gaudelet",
             music_tastes: "Disco, Funk, Soul")

file = URI.open("https://source.unsplash.com/WNoLnJo7tS8")
user_jebg.photos.attach(io: file, filename: "avatar0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/2LowviVHZ-E")
user_jebg.photos.attach(io: file, filename: "avatar2-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/lLdGG3ESoiI")
user_jebg.photos.attach(io: file, filename: "avatar3-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/5OyGRn_r9Y4")
user_jebg.photos.attach(io: file, filename: "avatar4-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/bodgc6H44FA")
user_jebg.photos.attach(io: file, filename: "avatar5-0.png", content_type: "image/png")
user_jebg.save!

puts "adding preference to Jeau-Eudes"
Preference.create!(user_id: user_jebg.id,
                   min_age: 18,
                   max_age: 99,
                   gender: "M",
                   max_distance: 5)

puts "creating Michel-Du-75@gmail.com and azerty login"
age = DateTime.now - 43.years
user_mich = User.create!(email: "Michel-Du-75@gmail.com",
             password: "azerty",
             first_name: "Michel",
             last_name: "Du-75",
             birthdate: age,
             description: "Coucou à tous ! Difficile de se décrire hihi. J'ai #{DateTime.now.year - age.year} ans, je suis fraîchement séparé et heureux papa de 2 merveilleux enfants. Je recherche la personne qui fera de nouveau vibrer mon coeur. Si tu aimes le sport et Derrick, c'est un plus.",
             gender: "M",
             address: "16 villa gaudelet",
             music_tastes: "Rock, Chanson française, Classique")

file = URI.open("https://source.unsplash.com/s3mR42Spras")
user_mich.photos.attach(io: file, filename: "avatar0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/hSB2HmJYaTo")
user_mich.photos.attach(io: file, filename: "avatar2-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/d3bYmnZ0ank")
user_mich.photos.attach(io: file, filename: "avatar3-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/z_MlmEelJpE")
user_mich.photos.attach(io: file, filename: "avatar4-0.png", content_type: "image/png")
file = URI.open("https://source.unsplash.com/KLLcTHE20bI")
user_mich.photos.attach(io: file, filename: "avatar5-0.png", content_type: "image/png")
user_mich.save!

puts "creating Match between Jean-Eudes et Michel"

match = Match.create!(user_1_id: user_jebg.id,
              user_2_id: user_mich.id,
              track_id: rand(1..100))

puts "creating messages between Jean-Eudes et Michel"

Message.create!(match_id: match.id,
                user_id: user_jebg.id,
                content: "Salut 👋 ça fart ?")
sleep(2)

Message.create!(match_id: match.id,
                user_id: user_mich.id,
                content: "Hello 👋 ça fart bien ici, et toi biloute ?")
sleep(2)

Message.create!(match_id: match.id,
                user_id: user_jebg.id,
                content: "Oklm fréro")
sleep(2)

Message.create!(match_id: match.id,
                user_id: user_jebg.id,
                content: "Tu suces ?")

puts "creating user n°1"
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
age = DateTime.now - (19..90).to_a.sample.years
puts "#{first_name}.#{last_name}@gmail.com"
user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                    password: "azerty",
                    first_name: first_name,
                    last_name: last_name,
                    birthdate: age,
                    description: "Hello ! Fan de festivals techno, de soirées en tout genre et pilier de bar, j'aurais besoin de quelqu'un pour m'accompagner au mariage de ma soeur. Peut-être que ça sera toi !",
                    gender: ["M","F","Other"].sample,
                    address: "16 villa gaudelet",
                    music_tastes: "Electro, Techno, New wave")
(2..7).to_a.sample.times do
  puts "photo"
  file = URI.open("https://source.unsplash.com/random/?profile")
  user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
end
user.save!

puts "creating user n°2"
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
age = DateTime.now - (19..90).to_a.sample.years
puts "#{first_name}.#{last_name}@gmail.com"
user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                    password: "azerty",
                    first_name: first_name,
                    last_name: last_name,
                    birthdate: age,
                    description: "Hey toi, je cherche à sortir de cette application le plus rapidement possible. J'aimerais quelqu'un avec qui voyager et qui aime cuisiner car je ne sais rien faire de mes 10 doigts.",
                    gender: ["M","F","Other"].sample,
                    address: "16 villa gaudelet",
                    music_tastes: "Rock, Karaoké, Métal")
(2..7).to_a.sample.times do
  puts "photo"
  file = URI.open("https://source.unsplash.com/random/?profile")
  user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
end
user.save!

puts "creating user n°3"
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
age = DateTime.now - (19..90).to_a.sample.years
puts "#{first_name}.#{last_name}@gmail.com"
user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                    password: "azerty",
                    first_name: first_name,
                    last_name: last_name,
                    birthdate: age,
                    description: "Bonjour vous, Je n'aime pas les descriptions. Allons plutôt boire un verre ! (chez moi ou chez toi ?)",
                    gender: ["M","F","Other"].sample,
                    address: "16 villa gaudelet",
                    music_tastes: "Techno, Trans, Hardcore")
(2..7).to_a.sample.times do
  puts "photo"
  file = URI.open("https://source.unsplash.com/random/?profile")
  user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
end
user.save!

puts "creating user n°4"
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
age = DateTime.now - (19..90).to_a.sample.years
puts "#{first_name}.#{last_name}@gmail.com"
user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                    password: "azerty",
                    first_name: first_name,
                    last_name: last_name,
                    birthdate: age,
                    description: "Coucou, moi c'est #{first_name} #{last_name}, j'ai #{DateTime.now.year - age.year} ans. J'aime le fooding, les voyages, et l'humour ! Pas de one shot SVP...",
                    gender: ["M","F","Other"].sample,
                    address: "Tour Eiffel",
                    music_tastes: "J'écoute de tout !",
                    latitude: 48.855782,
                    longitude: 2.293629)
(2..7).to_a.sample.times do
  puts "photo"
  file = URI.open("https://source.unsplash.com/random/?profile")
  user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
end
user.save!

puts "Database ready"
