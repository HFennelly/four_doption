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

User.create!(email: Faker::Internet.email, password: "123456", name: Faker::FunnyName.name, address: Faker::Address.street_address) # 1st fake user created
 Pet.create!(
  user: User.last,
  name: Faker::TvShows::BojackHorseman.character,
  species: ['cat', 'dog'].sample,
  age: [1, 2, 3, 4, 5, 6, 7].sample,
  breed: ['chow chow', 'labrador'].sample,
  size: ['big', 'medium', 'small'].sample,
  needs_garden: [true, false].sample,
  adopted: false,
  adoption_fee: [100, 200, 300, 400, 500].sample,
  location: Faker::Address.city,
) # one pet created, belonging to this user (no applications, no favourites belonging to this user)

10.times do
u = User.create!(email: Faker::Internet.email, password: "123456", name: Faker::FunnyName.name, address: Faker::Address.street_address) # 10 fake users created
  2.times do # 20 times per each fake user
    pet = Pet.create!(
      user: u,
      sex: ['male', 'female'].sample,
      name: Faker::TvShows::BojackHorseman.character,
      species: ['cat', 'dog', 'bird', 'hamster','rabbit'].sample,
      age: [1, 2, 3, 4, 5, 6, 7].sample,
      breed: ['chow chow', 'labrador'].sample,
      size: ['big', 'medium', 'small'].sample,
      needs_garden: [true, false].sample,
      adopted: false,
      adoption_fee: [100, 200, 300, 400, 500].sample,
      location: ["16 Villa Gaudelet, Paris", "97-99 Kings Rd, Brighton", "200 Santa Monica Pier, Santa Monica"].sample
    ) # 20 pets are created and attached per fake user

    application = Application.create!(
      user: u,
      pet: Pet.where.not(user: u).sample,
      requirements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )  # 20 applications are created and attached per fake user
    favourite = Favourite.create!(
      user: u,
      pet: Pet.where.not(user: u).sample
    ) # 20 favourites are created and attached per fake user
    puts pet.name
  end
end
