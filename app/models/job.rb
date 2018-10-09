class Job < ApplicationRecord
  has_many(:job_candidates, -> { order('score DESC') }, inverse_of: :job)
end
