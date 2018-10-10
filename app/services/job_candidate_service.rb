class JobCandidateService
  attr_reader :score_service

  def initialize(score_service = ScoreService.new)
    @score_service = score_service
  end

  def create(job_candidate_params)
    job_candidate = JobCandidate.new(job_candidate_params)
    job_candidate.score = score_service.call(job_candidate.job,
                                             job_candidate.person)
    job_candidate
  end
end
