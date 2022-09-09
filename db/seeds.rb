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
Message.destroy_all
BlockedUser.destroy_all
Match.destroy_all
User.destroy_all

puts "creating Michel-Du-75@gmail.com and azerty login"
age = DateTime.now - 43.years
user_mich = User.create!(email: "francoisjarry1@gmail.com",
             password: "azerty",
             first_name: "Michel",
             last_name: "Du-75",
             birthdate: age,
             description: "Hello everyone! It's hard to describe yourself hehe. I am #{DateTime.now.year - age.year} years old, recently separated and happy father of 2 wonderful children. I am looking for the person who will make my heart vibrate again. If you like sports and Derrick, that's a plus.",
             gender: "M",
             address: "16 villa gaudelet",
             music_tastes: "Rock, Old french songs, Classic")

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

puts "creating Mich preferences"

Preference.create!(
  user_id: user_mich.id,
  min_age: 18,
  max_age: 99,
  max_distance: 10,
  gender: "M"
)

counter = 1
full_name = []
keep = true

10.times do
  puts "creating user n°#{counter}"
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  while keep
    if full_name.include?("#{first_name} #{last_name}")
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
    else
      full_name.append("#{first_name} #{last_name}")
      keep = false
    end
  end
  age = DateTime.now - (19..40).to_a.sample.years
  puts "#{first_name}.#{last_name}@gmail.com"
  user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                      password: "azerty",
                      first_name: first_name,
                      last_name: last_name,
                      birthdate: age,
                      description: "Hello ! Fan of techno festivals, parties of all kinds and bar pillar, I would need someone to come with me to my sister's wedding. Maybe it will be you!",
                      gender: "M",
                      address: "Paris #{counter}",
                      music_tastes: "Electro, Techno, New wave")
  puts "Adding Photos"
  (2..4).to_a.sample.times do
    file = URI.open("https://source.unsplash.com/random/?profile")
    user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
  end
  user.save!
  counter += 1
  keep = true
end

puts "creating Jean-Eudes.BG@gmail.com and azerty login"
age = DateTime.now - 25.years
user_jebg = User.create!(email: "Jean-Eudes.BG@gmail.com",
             password: "azerty",
             first_name: "Jean-Eudes",
             last_name: "BG",
             birthdate: age,
             description: "Hi Biloute, I'm Jean-Eudes BG, the BG of Paris 17. I'm #{DateTime.now.year - age.year} years old. My typical afternoon is Ricard in front of Sardou. In life I don't like debates: there's no need to wiggle your ass to shit straight.",
             gender: "M",
             address: "31 Rue de Saintonge, 75003 Paris",
             music_tastes: "Disco, Funk, Synthwave")

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

Preference.create!(
  user_id: user_jebg.id,
  min_age: 18,
  max_age: 99,
  max_distance: 10,
  gender: "M"
)

puts "Jean-eudes like Mich"

Match.create!(
  user_2_id: user_mich.id,
  user_1_id: user_jebg.id,
  track_id: "1"
)

10.times do
  puts "creating user n°#{counter}"
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  while keep
    if full_name.include?("#{first_name} #{last_name}")
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
    else
      full_name.append("#{first_name} #{last_name}")
      keep = false
    end
  end
  age = DateTime.now - (21..30).to_a.sample.years
  puts "#{first_name}.#{last_name}@gmail.com"
  user = User.create!(email: "#{first_name}.#{last_name}@gmail.com",
                      password: "azerty",
                      first_name: first_name,
                      last_name: last_name,
                      birthdate: age,
                      description: "Hello ! Fan of techno festivals, parties of all kinds and bar pillar, I would need someone to come with me to my sister's wedding. Maybe it will be you!",
                      gender: "M",
                      address: "Paris #{counter}",
                      music_tastes: "Electro, Techno, New wave")
  puts "Adding Photos"
  (2..4).to_a.sample.times do
    file = URI.open("https://source.unsplash.com/random/?profile")
    user.photos.attach(io: file, filename: "avatar.png", content_type: "image/png")
  end
  user.save!
  counter += 1
  keep = true
end

puts "Database ready"
