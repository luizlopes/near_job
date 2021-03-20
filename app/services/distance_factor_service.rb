class DistanceFactorService
  def initialize(best_way_service = BestWayService.new)
    @best_way_service = best_way_service
  end

  def call(source, target)
    lower_cost_distance = best_way_service.find_lower_distance(source, target)
    find_distance_to(lower_cost_distance).factor
  end

  private

  attr_reader :best_way_service

  def find_distance_to(distance)
    DistanceFactor.where(':distance >= initial AND :distance <= final', distance: distance).first
  end
end
