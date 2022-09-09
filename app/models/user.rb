class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets
  has_many :applications
  has_many :favourites
  has_many :messages_as_sender, class_name: "Message", foreign_key: :sender_id
  has_many :messages_as_receiver, class_name: "Message", foreign_key: :receiver_id

  def owned_pet_applications
    Application.where(pet_id: Pet.where(user: self).pluck(:id))
  end

  def owned_pets_listed_for_adoption
    Pet.where(user: self).pluck(:id)
  end

  def submitted_application
    Application.where(user: self).pluck(:id)
  end
end
