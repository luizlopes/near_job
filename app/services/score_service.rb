class ScoreService
  def initialize(score_services: [Scores::DistanceScoreService, Scores::LevelScoreService])
    @score_services = score_services
  end

  def call(job, person)
    @score_services.map { |score_service| score_service.call(job: job, person: person) }.reduce(&:+)
  end
end
