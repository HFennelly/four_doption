class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.integer :age
      t.string :breed
      t.string :location
      t.string :sex
      t.string :species
      t.string :name
      t.boolean :needs_garden
      t.string :size
      t.boolean :adopted
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
