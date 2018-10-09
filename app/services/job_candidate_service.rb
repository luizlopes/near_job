class JobCandidateService
  def initialize(score_service)
    @score_service = score_service
  end

  def create(job_candidate_params)
    job_candidate = JobCandidate.new(job_candidate_params)
    job_candidate.score = @score_service.call(job_candidate)
    job_candidate
  end
end
