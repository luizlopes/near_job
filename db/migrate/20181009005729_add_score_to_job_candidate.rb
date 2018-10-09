class AddScoreToJobCandidate < ActiveRecord::Migration[5.2]
  def change
    add_column :job_candidates, :score, :integer
  end
end
