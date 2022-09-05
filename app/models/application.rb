class Application < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :messages
end
