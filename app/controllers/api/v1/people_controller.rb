module Api
  module V1
    class PeopleController < ApplicationController
      def_param_group :person_record do
        param :nome, String, 'Nome do profissional', required: true
        param :profissao, String, 'Profissão', required: true
        param :localizacao, String, 'Localização do profissional',
              required: true
        param :nivel, Integer, 'Nivel do profissional', required: true
        param :experiencia, String, 'Experiencia profissional'
      end

      api :POST, '/v1/pessoas', 'Cria uma nova pessoa'
      param_group :person_record
      def create
        person = Person.new(person_params)
        if person.save
          render json: person, status: :created, serializer: PeopleSerializer
          return
        end
        render_json_validation_error person, :validation_error
      end

      private

      def person_params
        params.permit(:nome, :profissao, :localizacao, :nivel, :experiencia)
      end
    end
  end
end
