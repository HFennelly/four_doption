class Pet < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  geocoded_by :location
  validates :breed, presence: true
  validates :species, presence: true
  after_validation :geocode, if: :will_save_change_to_location?
  has_many :applications
    has_many :favourites

  include PgSearch::Model
  # multisearchable against: {:location, :species, :sex}
  pg_search_scope :search_by_location,
    against: [ :location ],
    using: { tsearch: { prefix: true } }
end
