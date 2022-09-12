# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"
require "nokogiri"

Message.delete_all
Application.delete_all
Favourite.delete_all
Pet.delete_all
User.delete_all


woodgreen_dog = "https://woodgreen.org.uk/pets/?species=dog&pPage=1#038;pPage=2"

woodgreen = User.create(email: "woodgreen@woodgreen.com", password: "123456", name: "Woodgreen", address: "King's Bush Farm, London Road, Godmanchester, Huntingdon, United Kingdom", domain: "https://www.woodgreen.org.uk/", rescue: true, description: "woodgreen rescue center for animals" )

html_file = URI.open(woodgreen_dog).read
html_doc = Nokogiri::HTML(html_file)


html_doc.search(".c-pet-card").first(24).each do |element|
  element.search(".c-pet-card__inner").each do |link|
    inner_link = link.attribute("href").value
    dog_html_file = URI.open(inner_link).read
    dog_html_doc = Nokogiri::HTML(dog_html_file)
    if dog_html_doc.search(".c-hero--pet-single-details__reserved").present?
      avilable = false
    else
      avilable = true
    end
    name = dog_html_doc.search(".c-hero--pet-single-details__pet-name").text.strip
    dog_info = dog_html_doc.search(".c-hero--pet-single-details li").children.first(3)
    breed = dog_info[0]
    age = dog_info[1].text.strip.split[0].to_i
    sex = dog_info[2]
    description = dog_html_doc.search(".c-hero--pet-single-details p").text.strip
    dog_image = dog_html_doc.search(".swiper-slide img").attribute("src")
    pet = Pet.create(age: age, breed: breed, location: "King's Bush Farm, London Road, Godmanchester, Huntingdon, United Kingdom", sex: sex, species: "dog", name: name, needs_garden: true, size: ["small", "medium", "large"].sample, adopted: avilable, description: description, user: woodgreen)
    file = URI.open(dog_image)
    pet.photo.attach(io: file, filename: "#{name}.png", content_type: "image/png")
    puts pet.name
  end
end



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
  location: Faker::Address.city)
one pet created, belonging to this user (no applications, no favourites belonging to this user)

5.times do
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
    ) # 10 pets are created and attached per fake user

    application = Application.create!(
      user: u,
      pet: Pet.where.not(user: u).sample,
      requirements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )  # 10 applications are created and attached per fake user
    favourite = Favourite.create!(
      user: u,
      pet: Pet.where.not(user: u).sample
    ) # 10 favourites are created and attached per fake user
    puts pet.name
  end
end
