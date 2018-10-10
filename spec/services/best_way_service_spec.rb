require 'rails_helper'

describe BestWayService do
  let(:estimates_service) { EstimatesService.new }

  it 'from location to it self' do
    best_way = BestWayService.new(estimates_service)

    distance = best_way.find_lower_distance('A', 'A')
    expect(distance).to eq 0
  end

  context 'when from location to another directly linked' do
    before do
      estimates_service.add 'A', 'B', 5
      estimates_service.add 'B', 'A', 5
    end

    it 'distance of between A and B should be 5' do
      best_way = BestWayService.new estimates_service
      distance = best_way.find_lower_distance('A', 'B')
      expect(distance).to eq 5
    end
  end

  context 'when from location to another directly linked' do
    before do
      estimates_service.add 'A', 'B', 5
      estimates_service.add 'B', 'A', 5
      estimates_service.add 'B', 'C', 4
      estimates_service.add 'C', 'B', 4
      estimates_service.add 'A', 'C', 15
      estimates_service.add 'C', 'A', 15
      estimates_service.add 'C', 'D', 3
      estimates_service.add 'D', 'C', 3
    end

    it 'distance of between B and A should be 5' do
      best_way = BestWayService.new estimates_service
      distance = best_way.find_lower_distance('B', 'A')
      expect(distance).to eq 5
    end
  end

  context 'when from location to another with different ways' do
    before do
      estimates_service.add 'A', 'B', 5
      estimates_service.add 'B', 'A', 5
      estimates_service.add 'B', 'C', 4
      estimates_service.add 'C', 'B', 4
      estimates_service.add 'A', 'C', 15
      estimates_service.add 'C', 'A', 15
      estimates_service.add 'C', 'D', 3
      estimates_service.add 'D', 'C', 3
    end

    it 'distance of between A and C should be 9' do
      best_way = BestWayService.new estimates_service
      distance = best_way.find_lower_distance('A', 'C')
      expect(distance).to eq 9
    end
  end

  context 'when from location to another third level linked' do
    before do
      estimates_service.add 'A', 'B', 5
      estimates_service.add 'B', 'A', 5
      estimates_service.add 'B', 'C', 4
      estimates_service.add 'C', 'B', 4
      estimates_service.add 'A', 'C', 15
      estimates_service.add 'C', 'A', 15
      estimates_service.add 'C', 'D', 3
      estimates_service.add 'D', 'C', 3
    end

    it 'distance of between A and D should be 12' do
      best_way = BestWayService.new estimates_service
      distance = best_way.find_lower_distance('A', 'D')
      expect(distance).to eq 12
    end
  end

  context 'when from location to unreachable location' do
    before do
      estimates_service.add 'A', 'B', 5
      estimates_service.add 'B', 'A', 5
      estimates_service.add 'B', 'C', 4
      estimates_service.add 'C', 'B', 4
      estimates_service.add 'A', 'C', 15
      estimates_service.add 'C', 'A', 15
      estimates_service.add 'C', 'D', 3
      estimates_service.add 'D', 'C', 3
    end

    it 'distance of between A and H should be -1' do
      best_way = BestWayService.new estimates_service
      distance = best_way.find_lower_distance('A', 'H')
      negative = -1
      expect(distance).to eq negative
    end
  end
end
