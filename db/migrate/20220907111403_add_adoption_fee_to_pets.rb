class AddAdoptionFeeToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :adoption_fee, :integer
  end
end
