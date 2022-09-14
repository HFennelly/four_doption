class Application < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :messages
  # validates :approved, presence: true
  validate :user_id_cant_apply_for_own_pet

  def user_id_cant_apply_for_own_pet
    if self.pet.user == self.user
      errors.add(:user_id, "You can't apply for your own pet! You can choose to delete this listing.")
    end
  end



end
