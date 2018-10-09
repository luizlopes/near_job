class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :title
      t.text :description
      t.string :localization
      t.integer :level

      t.timestamps
    end
  end
end
