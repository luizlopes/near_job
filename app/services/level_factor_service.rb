module LevelFactorService
  class << self
    def call(job_level, person_level)
      100 - 25 * (job_level - person_level).abs
    end
  end
end
