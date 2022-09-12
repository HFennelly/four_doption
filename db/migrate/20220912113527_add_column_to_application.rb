class AddColumnToApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :validated, :boolean
  end
end
