class AddProfessionalBackgroundToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :professional_background, :string
  end
end
