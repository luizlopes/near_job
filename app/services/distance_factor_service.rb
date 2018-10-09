class DistanceFactorService
  def initialize(best_way_service = nil)
    @best_way_service = best_way_service
  end

  def call(source, target)
    lower_cost_distance = @best_way_service.find_lower_cost(source, target)

    find_distance_factor_to(lower_cost_distance).factor
  end

  def find_distance_factor_to(distance)
    distance_factor = DistanceFactor.where('(:distance >= initial '\
                                           'AND :distance <= final)',
                                           distance: distance)
    distance_factor[0]
  end
end
