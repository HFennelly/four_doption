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

woodgreen = User.create(email: "default@woodgreen.org.uk", password: "123456", name: "Woodgreen", address: "King's Bush Farm, London Road, Godmanchester, Huntingdon, United Kingdom", domain: "https://www.woodgreen.org.uk/", rescue: true, description: "Every year, Woodgreen’s dedicated teams work tirelessly to provide safe shelter, specialist care, and a brighter future for thousands of pets. And we’re here for owners in need of advice and support too, every step of the way. Our teams work together to create an individual plan for every pet – from medical treatment to behaviour training. And when the pet is ready, we find them a loving home where they can live a happy, fulfilling life." )

html_file = URI.open(woodgreen_dog).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search(".c-pet-card").first(24).each do |element|
  element.search(".c-pet-card__inner").each do |link|
    inner_link = link.attribute("href").value
    dog_html_file = URI.open(inner_link).read
    dog_html_doc = Nokogiri::HTML(dog_html_file)
    if dog_html_doc.search(".c-hero--pet-single-details__reserved").present?
      adopted = true
    else
      adopted = false
    end
    name = dog_html_doc.search(".c-hero--pet-single-details__pet-name").text.strip
    dog_info = dog_html_doc.search(".c-hero--pet-single-details li").children.first(3)
    breed = dog_info[0].text.titleize
    age = dog_info[1].text.strip.split[0].to_i
    sex = dog_info[2].text.titleize
    description = dog_html_doc.search(".c-hero--pet-single-details p").text.strip
    dog_image = dog_html_doc.search(".swiper-slide img").attribute("src")
    pet = Pet.create(age: age, breed: breed, location: "Kings Bush Farm, Godmanchester, UK", sex: sex, species: "Dog", name: name, needs_garden: true, size: ["Small", "Medium", "Large"].sample, adopted: adopted, description: description, user: woodgreen)
    file = URI.open(dog_image)
    pet.photo.attach(io: file, filename: "#{name}.png", content_type: "image/png")
    puts pet.name
  end
end

woodgreen_cat = "https://woodgreen.org.uk/pets/?species=cat&pPage=1#038;pPage=2"
cat_first_html_file = URI.open(woodgreen_cat).read
cat_first_html_doc = Nokogiri::HTML(cat_first_html_file)
cat_first_html_doc.search(".c-pet-card").first(15).each do |element|
  element.search(".c-pet-card__inner").each do |link|
    cat_inner_link = link.attribute("href").value
    cat_html_file = URI.open(cat_inner_link).read
    cat_html_doc = Nokogiri::HTML(cat_html_file)
    if cat_html_doc.search(".c-hero--pet-single-details__reserved").present?
      adopted = true
    else
      adopted = false
    end
    cat_name = cat_html_doc.search(".c-hero--pet-single-details__pet-name").text.strip
    # gets the cat's name
    cat_info = cat_html_doc.search(".c-hero--pet-single-details li").children.first(3)
    cat_breed = cat_info[0].text.titleize
    # gets the breed
    cat_age = cat_info[1].text.strip.split[0].to_i
    # gets the age and extracts just the number from "2 years" returning as an interga
    cat_sex = cat_info[2].text.titleize
    # gets the sex of the cat
    description = cat_html_doc.search(".c-pet-detail > p").text.strip
    # takes a description from the bottom of the page, it's in a different place the one used in dog scrape.
    cat_image = cat_html_doc.search(".swiper-slide img").attribute("src")
    # takes the first image from the webpage
    cat = Pet.create(age: cat_age, breed: cat_breed, location: "Kings Bush Farm, Godmanchester, UK", sex: cat_sex, species: "Cat", name: cat_name, needs_garden: true, size: ["Small", "Medium", "Large"].sample, description: description, adopted: adopted, user: woodgreen)
    file = URI.open(cat_image)
    cat.photo.attach(io: file, filename: "#{cat_name}.png", content_type: "image/png")
    puts cat.name
  end
end


animal_rescue_and_care = User.create(email: "default@animalrescueandcare.org.uk", password: "123456", name: "Animal Rescue and Care", address: "Twickenham, London, TW1 1WG", domain: "https://animalrescueandcare.org.uk/", rescue: true, description: "When five women got together in 2001, their vision was that every animal in the Richmond Upon Thames area should be loved and cared for. Animal Rescue and Care (A.R.C.) has grown from small beginnings to a local charity that has helped over 8,000 animals. Our priority is to rescue, foster and rehome animals in the Richmond Upon Thames area. We work mainly with cats, rabbits and guinea pigs, but also with dogs and ‘small furries’ such as hamsters and chinchillas.")

animal_rescue_and_care_rabbit = "https://animalrescueandcare.org.uk/adopt-a-rabbit/"
rabbit_html_file = URI.open(animal_rescue_and_care_rabbit).read
rabbit_html_doc = Nokogiri::HTML(rabbit_html_file)
rabbit_html_doc.search(".entry-title  > a").first(15).each_with_index do |link, index|
  unless index == 0
    rabbit_inner_link = link.attribute("href").value
    rabbit_inner_html_file = URI.open(rabbit_inner_link).read
    rabbit_inner_html_doc = Nokogiri::HTML(rabbit_inner_html_file)
    rabbit_name = rabbit_inner_html_doc.search(".project-info h3").text.strip.split(" (")[0]
    check = rabbit_inner_html_doc.search(".project-info h3").text.strip.split(" (")[1]
    age_array = check.split(/\W/).pop(3)
    rabbit_age = age_array.select {|num| num.to_i != 0}.first.to_i
    rabbit_hash = rabbit_inner_html_doc.search(".project-info-box")
    hash = {}
    rabbit_hash.each do |info|
      hash[info.search("h4").text.strip] = info.search(".project-terms").text.strip
    end
    rabbit_sex = hash["Sex:"].titleize
    if hash["Breed:"] == nil
      rabbit_breed = ""
    else
      rabbit_breed = hash["Breed:"].titleize
    end
    if hash["Status:"] == "Available"
      rabbit_adopted = false
    else
      rabbit_adopted == true
    end
    rabbit_description = rabbit_inner_html_doc.search(".project-description p").text.strip
    rabbit_img = rabbit_inner_html_doc.search(".fusion-flexslider img").attribute("src")

    rabbit = Pet.create(age: rabbit_age, breed: rabbit_breed, location: "Twickenham, London, UK,
      TW1 1WG", sex: rabbit_sex, species: "Rabbit", name: rabbit_name, needs_garden: true, size: ["Small", "Medium", "Large"].sample, adopted: rabbit_adopted, description: rabbit_description, user: animal_rescue_and_care)
      file = URI.open(rabbit_img)
    rabbit.photo.attach(io: file, filename: "#{rabbit_name}.png", content_type: "image/png")
    puts rabbit.name
    end
  end


User.create!(email: Faker::Internet.email, password: "123456", name: Faker::FunnyName.name, address: Faker::Address.street_address) # 1st fake user created
# one pet created, belonging to this user (no applications, no favourites belonging to this user

5.times do
u = User.create!(email: Faker::Internet.email, password: "123456", name: Faker::FunnyName.name, address: Faker::Address.street_address) # 10 fake users created
  2.times do # 10 times per each fake user
    application = Application.create!(
      user: u,
      pet: Pet.where.not(user: u).sample,
      requirements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )  # 10 applications are created and attached per fake user
    favourite = Favourite.create!(
      user: u,
      pet: Pet.where.not(user: u).sample
    ) # 10 favourites are created and attached per fake user
  end
end
