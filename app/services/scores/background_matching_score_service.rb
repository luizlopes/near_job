module Scores
  class BackgroundMatchingScoreService
    def self.call(job:, person:)
      new(job, person).call
    end

    def initialize(job, person)
      @job = job
      @person = person
    end

    def call
      return MATCHES_VALUE if professional_background_matches_job_description?

      DOESNT_MATCH_VALUE
    end

    private

    DOESNT_MATCH_VALUE = 0
    MATCHES_VALUE = 50

    attr_reader :job, :person

    def professional_background_matches_job_description?
      return false if person.professional_background.blank?

      job.description.downcase.include?(person.professional_background.downcase)
    end
  end
end
