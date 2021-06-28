require 'rails_helper'

describe Scores::DistanceScoreService do
  subject(:distance_factor) do
    described_class.call(job: a_job, person: a_person, best_way_service: best_way_service)
  end

  let(:a_job) { build(:job, localization: 'A') }
  let(:a_person) { build(:person, localization: 'B') }

  before do
    create :distance_factor, initial: 0, final: 5, factor: 100
    create :distance_factor, initial: 6, final: 10, factor: 75
    create :distance_factor, initial: 11, final: 15, factor: 50
    create :distance_factor, initial: 16, final: 20, factor: 25
    create :distance_factor, initial: 21, final: 999, factor: 0
  end

  let(:best_way_service) { double(:best_way_service, find_lower_distance: lower_distance) }

  context 'when the distance factor for cost equals to 0' do
    let(:lower_distance) { 0 }

    it 'must return 50' do
      expect(distance_factor).to eq(50)
    end
  end

  context 'when the distance factor for cost equals to 4' do
    let(:lower_distance) { 4 }

    it 'must return 50' do
      expect(distance_factor).to eq(50)
    end
  end

  context 'when the distance factor for cost equals to 8' do
    let(:lower_distance) { 8 }

    it 'must return 37' do
      expect(distance_factor).to eq(37)
    end
  end

  context 'when the distance factor for cost equals to 20' do
    let(:lower_distance) { 20 }

    it 'must return 12' do
      expect(distance_factor).to eq(12)
    end
  end

  context 'when the distance factor for cost equals to 21' do
    let(:lower_distance) { 21 }

    it 'must return 0' do
      expect(distance_factor).to eq(0)
    end
  end
end
