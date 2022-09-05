class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :rescue, :string
    add_column :users, :address, :string
    add_column :users, :domain, :string
  end
end
