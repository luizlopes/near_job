require 'rails_helper'

describe Scores::LevelScoreService do
  subject(:level_score_service) { described_class.call(job: a_job, person: a_person) }

  let(:a_job) { build(:job, level: job_level) }
  let(:a_person) { build(:person, level: person_level) }

  context 'when job level is 1 and person level is 5' do
    let(:job_level) { 1 }
    let(:person_level) { 5 }

    it 'must returns 0' do
      is_expected.to eq(0)
    end
  end

  context 'when job level is 3 and person level is 5' do
    let(:job_level) { 3 }
    let(:person_level) { 5 }

    it 'must returns 25' do
      is_expected.to eq(25)
    end
  end

  context 'when job level is 5 and person level is 5' do
    let(:job_level) { 5 }
    let(:person_level) { 5 }

    it 'must returns 50' do
      is_expected.to eq(50)
    end
  end
end
