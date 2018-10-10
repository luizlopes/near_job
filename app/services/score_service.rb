class ScoreService
  attr_reader :level_factor_service, :distance_factor_service

  def initialize(level_factor_service = LevelFactorService,
                 distance_factor_service = DistanceFactorService.new)
    @level_factor_service = level_factor_service
    @distance_factor_service = distance_factor_service
  end

  def call(job, person)
    level_factor = level_factor_service.call(job.level, person.level)
    distance_factor = distance_factor_service.call(job.localization,
                                                   person.localization)
    (level_factor + distance_factor) / 2
  end
end
