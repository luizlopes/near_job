class RankingSerializer < ActiveModel::Serializer
  attributes :nome, :profissao, :localizacao, :nivel, :score

  def nome
    object.person.name
  end

  def profissao
    object.person.career
  end

  def localizacao
    object.person.localization
  end

  def nivel
    object.person.level
  end
end
