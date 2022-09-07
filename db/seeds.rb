# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

Message.delete_all
Application.delete_all
Favourite.delete_all
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
      breed: ['chow chow', 'labrador'].sample,
      size: ['big', 'medium', 'small'].sample,
      needs_garden: [true, false].sample,
      adopted: false,
      adoption_fee: [100, 200, 300, 400, 500].sample,
      location: Faker::Address.city
    )

    application = Application.create!(
      user: u,
      pet: pet,
      requirements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )
    favourite = Favourite.create!(
      user: u,
      pet: pet
    )
    puts pet.name
  end
end
