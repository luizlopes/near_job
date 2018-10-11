class PeopleSerializer < ActiveModel::Serializer
  attributes :id, :nome, :profissao, :localizacao, :nivel
end
