class CreateDistanceFactors < ActiveRecord::Migration[5.2]
  def change
    create_table :distance_factors do |t|
      t.integer :initial
      t.integer :final
      t.integer :factor

      t.timestamps
    end
  end
end
