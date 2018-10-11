require 'rails_helper'

describe DistanceFactorService do
  let!(:factor_100) do
    create :distance_factor, initial: 0, final: 5, factor: 100
  end
  let!(:factor_75) do
    create :distance_factor, initial: 6, final: 10, factor: 75
  end
  let!(:factor_50) do
    create :distance_factor, initial: 11, final: 15, factor: 50
  end
  let!(:factor_25) do
    create :distance_factor, initial: 16, final: 20, factor: 25
  end
  let!(:factor_0) do
    create :distance_factor, initial: 21, final: 999, factor: 0
  end

  it 'get the distance factor for cost equals to 0' do
    best_way_service = double(:best_way_service, find_lower_distance: 0)

    distance_factor = DistanceFactorService.new(best_way_service)
                                           .call('A', 'B')
    expect(distance_factor).to eq(100)
  end

  it 'get the distance factor for cost equals to 4' do
    best_way_service = double(:best_way_service, find_lower_distance: 4)

    distance_factor = DistanceFactorService.new(best_way_service)
                                           .call('A', 'B')
    expect(distance_factor).to eq(100)
  end

  it 'get the distance factor for cost equals to 8' do
    best_way_service = double(:best_way_service, find_lower_distance: 8)

    distance_factor = DistanceFactorService.new(best_way_service)
                                           .call('A', 'B')
    expect(distance_factor).to eq(75)
  end

  it 'get the distance factor for cost equals to 20' do
    best_way_service = double(:best_way_service, find_lower_distance: 20)

    distance_factor = DistanceFactorService.new(best_way_service)
                                           .call('A', 'B')
    expect(distance_factor).to eq(25)
  end

  it 'get the distance factor for cost equals to 21' do
    best_way_service = double(:best_way_service, find_lower_distance: 21)

    distance_factor = DistanceFactorService.new(best_way_service)
                                           .call('A', 'B')
    expect(distance_factor).to eq(0)
  end
end
