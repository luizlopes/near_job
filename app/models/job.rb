class Job < ApplicationRecord
  has_many(:job_candidates, -> { order('score DESC') }, inverse_of: :job)

  alias_attribute :empresa, :company
  alias_attribute :titulo, :title
  alias_attribute :descricao, :description
  alias_attribute :localizacao, :localization
  alias_attribute :nivel, :level

  validates :company, :title, :description, :localization, :level,
            presence: true
  validates :level, inclusion: { in: 1..5 }
end
