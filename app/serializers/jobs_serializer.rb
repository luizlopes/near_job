class JobsSerializer < ActiveModel::Serializer
  attributes :id, :empresa, :titulo, :descricao, :localizacao, :nivel
end
