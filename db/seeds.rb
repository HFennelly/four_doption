# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

Pet.delete_all
User.delete_all

10.times do
u = User.create(email: Faker::Internet.email, password: "123456", name: Faker::FunnyName.name, address: Faker::Address.street_address)
  2.times do
    pet = Pet.create!(
      user: u,
      name: Faker::TvShows::BojackHorseman.character,
      species: ['cat', 'dog'].sample,
      age: [1, 2, 3, 4, 5, 6, 7].sample,
      breed: ['cat', 'dog'].sample,
      size: ['big', 'medium', 'small'].sample,
      needs_garden: [true, false].sample,
      adopted: false
    )
    puts pet.name
  end
end
