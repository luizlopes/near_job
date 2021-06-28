class JobCandidateService
  attr_reader :score_service

  def initialize(score_service: nil)
    @score_service = score_service || default_score_service
  end

  def create(job_candidate_params)
    job_candidate = JobCandidate.new(job_candidate_params)
    if job_candidate.valid?
      job_candidate.score = score_service.call(job_candidate.job,
                                               job_candidate.person)
    end
    job_candidate
  end

  private

  def default_score_service
    ScoreService.new(score_services: [
                       Scores::DistanceScoreService,
                       Scores::LevelScoreService,
                       Scores::BackgroundMatchingScoreService
                     ])
  end
end
