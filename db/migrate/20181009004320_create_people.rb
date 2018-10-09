class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :career
      t.string :localization
      t.integer :level

      t.timestamps
    end
  end
end
