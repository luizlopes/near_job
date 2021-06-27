require 'rails_helper'

describe BestWayService do
  subject(:find_lower_distance) { instance.find_lower_distance(source, target) }

  let(:instance) { described_class.new(estimates_service) }
  let(:estimates_service) { EstimatesService.new }

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

  context 'from location to it self' do
    let(:source) { 'A' }
    let(:target) { 'A' }

    it 'distance of between A and B should be 0' do
      is_expected.to eq 0
    end
  end

  context 'when from location to another directly linked' do
    let(:source) { 'A' }
    let(:target) { 'B' }

    it 'distance of between A and B should be 5' do
      is_expected.to eq 5
    end
  end

  context 'when from location to another directly linked' do
    let(:source) { 'B' }
    let(:target) { 'A' }

    it 'distance of between B and A should be 5' do
      is_expected.to eq 5
    end
  end

  context 'when from location to another with different ways' do
    let(:source) { 'A' }
    let(:target) { 'C' }

    it 'distance of between A and C should be 9' do
      is_expected.to eq 9
    end
  end

  context 'when from location to another third level linked' do
    let(:source) { 'A' }
    let(:target) { 'D' }

    it 'distance of between A and D should be 12' do
      is_expected.to eq 12
    end
  end

  context 'when from location to unreachable location' do
    let(:source) { 'A' }
    let(:target) { 'H' }

    it 'distance of between A and H should be -1' do
      is_expected.to be_negative
    end
  end
end
