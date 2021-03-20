require 'rails_helper'

describe DistanceFactorService do
  subject(:distance_factor) do
    described_class.new(best_way_service).call('A', 'B')
  end

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

    it 'must return 100' do
      expect(distance_factor).to eq(100)
    end
  end

  context 'when the distance factor for cost equals to 4' do
    let(:lower_distance) { 4 }

    it 'must return 100' do
      expect(distance_factor).to eq(100)
    end
  end

  context 'when the distance factor for cost equals to 8' do
    let(:lower_distance) { 8 }

    it 'must return 75' do
      expect(distance_factor).to eq(75)
    end
  end

  context 'when the distance factor for cost equals to 20' do
    let(:lower_distance) { 20 }

    it 'must return 25' do
      expect(distance_factor).to eq(25)
    end
  end

  context 'when the distance factor for cost equals to 21' do
    let(:lower_distance) { 21 }

    it 'must return 0' do
      expect(distance_factor).to eq(0)
    end
  end
end
