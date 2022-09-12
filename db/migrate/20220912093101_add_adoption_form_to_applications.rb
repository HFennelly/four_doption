class AddAdoptionFormToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :applicant_name, :string
    add_column :applications, :applicant_age, :string
    add_column :applications, :applicant_address, :string
    add_column :applications, :applicant_household, :text
    add_column :applications, :applicant_pets, :text
    add_column :applications, :applicant_home, :string
    add_column :applications, :applicant_hours, :string
    add_column :applications, :applicant_garden, :string
    add_column :applications, :additional_information, :text
  end
end
