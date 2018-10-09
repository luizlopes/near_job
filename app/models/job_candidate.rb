class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :person
  validates :person, uniqueness: { scope: :job }
end
