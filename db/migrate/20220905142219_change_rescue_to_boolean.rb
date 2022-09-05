class ChangeRescueToBoolean < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :rescue, :string
    add_column :users, :rescue, :boolean
  end
end
