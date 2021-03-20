require 'rails_helper'

describe ScoreService do
  subject(:score_service_call) do
    described_class.new(level_factor, distance_factor).call(a_job, a_person)
  end

  let(:a_job) { build(:job) }
  let(:a_person) { build(:person) }

  context 'when level factor equals 75 and distance factor equal 25' do
    let(:level_factor) { double(:level_factor, call: 75) }
    let(:distance_factor) { double(:distance_factor, call: 25) }

    it 'returns the sum divided by 2' do
      is_expected.to eq(50)
    end
  end

  context 'when level factor equals 100 and distance factor equal 50' do
    let(:level_factor) { double(:level_factor, call: 100) }
    let(:distance_factor) { double(:distance_factor, call: 50) }

    it 'returns the sum divided by 2' do
      is_expected.to eq(75)
    end
  end
end
