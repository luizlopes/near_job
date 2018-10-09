require 'rails_helper'

describe JobCandidateService do
  it 'creates a job candidates with score value' do
    score_service = double(:score_service, call: 50)

    job_candidate = JobCandidateService.new(score_service)
                                       .create(job_id: 1, person_id: 1)
    expect(job_candidate.score).to eq(50)
  end
end
