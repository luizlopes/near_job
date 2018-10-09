class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :person
end
