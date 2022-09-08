class Pet < ApplicationRecord
  has_many_attached :photo
  belongs_to :user
  has_many :applications
    has_many :favourites


  include PgSearch::Model
  # multisearchable against: {:location, :species, :sex}
  pg_search_scope :search_by_location,
    against: [ :location ],
    using: { tsearch: { prefix: true } }
end
