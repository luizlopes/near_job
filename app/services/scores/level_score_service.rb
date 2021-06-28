module Scores
  class LevelScoreService
    def self.call(job:, person:)
      new(job, person).call
    end

    def initialize(job, person)
      @job_level = job.level
      @person_level = person.level
    end

    def call
      (100 - 25 * (job_level - person_level).abs) / 2
    end

    private

    attr_reader :job_level, :person_level
  end
end
