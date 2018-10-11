class Person < ApplicationRecord
  alias_attribute :nome, :name
  alias_attribute :profissao, :career
  alias_attribute :localizacao, :localization
  alias_attribute :nivel, :level

  validates :name, :career, :localization, :level, presence: true
  validates :level, inclusion: { in: 1..5 }
end
