require 'rails_helper'

describe JobCandidateService do
  let!(:a_job) { create :job }
  let!(:a_person) { create :person }

  it 'creates a job candidates with score value' do
    score_service = double(:score_service, call: 50)

    job_candidate = JobCandidateService.new(score_service)
                                       .create(job_id: a_job.id,
                                               person_id: a_person.id)
    expect(job_candidate.score).to eq(50)
  end
end
