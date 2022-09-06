class Pet < ApplicationRecord
  belongs_to :user
  has_many :applications

  include PgSearch::Model
  # multisearchable against: {:location, :species, :sex}
  pg_search_scope :search_by_location,
    against: [ :location ],
    using: { tsearch: { prefix: true } }
end
