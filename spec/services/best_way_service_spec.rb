require 'rails_helper'

describe BestWayService do
  it 'from location to it self' do
    best_way = BestWayService.new EstimatesService.new
    distance = best_way.find_lower_distance('A', 'A')
    expect(distance).to eq 0
  end

  it 'from location to another directly linked' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('A', 'B')
    expect(distance).to eq 5
  end

  it 'from location to another directly linked (inverted)' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5
    estimates_service.add 'B', 'C', 4
    estimates_service.add 'C', 'B', 4
    estimates_service.add 'A', 'C', 15
    estimates_service.add 'C', 'A', 15
    estimates_service.add 'C', 'D', 3
    estimates_service.add 'D', 'C', 3

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('B', 'A')
    expect(distance).to eq 5
  end

  it 'from location to another second level linked' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5
    estimates_service.add 'B', 'C', 4
    estimates_service.add 'C', 'B', 4
    estimates_service.add 'A', 'C', 15
    estimates_service.add 'C', 'A', 15
    estimates_service.add 'C', 'D', 3
    estimates_service.add 'D', 'C', 3

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('A', 'C')
    expect(distance).to eq 9
  end

  it 'from location to another with different ways' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5
    estimates_service.add 'B', 'C', 4
    estimates_service.add 'C', 'B', 4
    estimates_service.add 'A', 'C', 15
    estimates_service.add 'C', 'A', 15
    estimates_service.add 'C', 'D', 3
    estimates_service.add 'D', 'C', 3

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('A', 'C')
    expect(distance).to eq 9
  end

  it 'from location to another third level linked' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5
    estimates_service.add 'B', 'C', 4
    estimates_service.add 'C', 'B', 4
    estimates_service.add 'A', 'C', 15
    estimates_service.add 'C', 'A', 15
    estimates_service.add 'C', 'D', 3
    estimates_service.add 'D', 'C', 3

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('A', 'D')
    expect(distance).to eq 12
  end

  it 'from location to ponto inalcansavel' do
    estimates_service = EstimatesService.new
    estimates_service.add 'A', 'B', 5
    estimates_service.add 'B', 'A', 5
    estimates_service.add 'B', 'C', 4
    estimates_service.add 'C', 'B', 4
    estimates_service.add 'A', 'C', 15
    estimates_service.add 'C', 'A', 15
    estimates_service.add 'C', 'D', 3
    estimates_service.add 'D', 'C', 3

    best_way = BestWayService.new estimates_service
    distance = best_way.find_lower_distance('A', 'H')
    negative = -1
    expect(distance).to eq negative
  end
end
