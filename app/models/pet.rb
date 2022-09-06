class Pet < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :applications
  has_many :favourites
end
