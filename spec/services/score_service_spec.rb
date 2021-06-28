require 'rails_helper'

describe ScoreService do
  subject(:score_service_call) do
    described_class.new(score_services: score_services).call(a_job, a_person)
  end

  let(:a_job) { build(:job) }
  let(:a_person) { build(:person) }

  context 'when three score services are passed' do
    let(:score_services) { [score_x, score_y, score_z] }
    let(:score_x) { double(:x, call: 75) }
    let(:score_y) { double(:y, call: 25) }
    let(:score_z) { double(:z, call: 50) }

    it 'returns the sum of all' do
      is_expected.to eq(150)
    end
  end
end
