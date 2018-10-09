class CreateJobCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :job_candidates do |t|
      t.references :job, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
