class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :source
      t.string :target
      t.integer :distance

      t.timestamps
    end
  end
end
