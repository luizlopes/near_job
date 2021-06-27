require 'rails_helper'

describe LevelFactorService do
  subject(:level_factor) { LevelFactorService.call(job_level, person_level) }

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

    it 'must returns 50' do
      is_expected.to eq(50)
    end
  end

  context 'when job level is 5 and person level is 5' do
    let(:job_level) { 5 }
    let(:person_level) { 5 }

    it 'must returns 100' do
      is_expected.to eq(100)
    end
  end
end
