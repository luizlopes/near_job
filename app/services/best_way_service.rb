class BestWayService
  attr_reader :estimates_service

  def initialize(estimates_service = EstimatesService.new)
    @estimates_service = estimates_service
  end

  def find_lower_distance(source, target)
    return 0 if source.eql? target
    calculate_distances_from(source)
    distance(source, target)
  end

  private

  def distance(source, target)
    estimate = estimates_service.find(source, target)
    estimate.present? ? estimate.first.distance : -1
  end

  def calculate_distances_from(source)
    while estimates_service.estimates_opened? source
      estimates_service.by_location(source).select(&:opened?)
                       .sort_by(&:distance)
                       .each do |estimate|
                         step_down(source, estimate)
                         estimate.close!
                       end
    end
  end

  def step_down(source, level_zero)
    estimates = estimates_service.by_location(level_zero.target)
    level_one_estimates = estimates.reject { |e| e.target.eql? source }
    level_one_estimates.each do |level_one|
      recalculate(source, level_zero, level_one)
    end
  end

  def recalculate(source, level_zero, level_one)
    distance = level_zero.distance + level_one.distance
    estimate = estimates_service.find(source, level_one.target)
    if estimate.present?
      change_estimate(estimate.first, distance, level_zero.target)
    else
      estimates_service.add_new(source, level_one.target, level_zero.target,
                                distance)
    end
  end

  def change_estimate(estimate, distance, previous)
    return if estimate.distance < distance
    estimate.previous = previous
    estimate.distance = distance
  end
end
