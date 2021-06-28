module Scores
  class DistanceScoreService
    def self.call(job:, person:, best_way_service: BestWayService.new)
      new(job, person, best_way_service).call
    end

    def initialize(job, person, best_way_service = BestWayService.new)
      @best_way_service = best_way_service
      @source = job.localization
      @target = person.localization
    end

    def call
      lower_cost_distance = best_way_service.find_lower_distance(source, target)
      find_distance_to(lower_cost_distance).factor / 2
    end

    private

    attr_reader :source, :target, :best_way_service

    def find_distance_to(distance)
      DistanceFactor.where(':distance >= initial AND :distance <= final', distance: distance).first
    end
  end
end
