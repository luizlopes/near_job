module Api
  module V1
    class JobsController < ApplicationController
      def_param_group :job_record do
        param :empresa, String, 'Nome da empresa', required: true
        param :titulo, String, 'Titulo da vaga', required: true
        param :descricao, String, 'Descrição da vaga', required: true
        param :localizacao, String, 'Localização da empresa', required: true
        param :nivel, String, 'Nivel da vaga', required: true
      end

      api :POST, '/v1/vagas', 'Cria uma nova vaga'
      param_group :job_record
      def create
        job = Job.new(job_params)
        if job.save
          render json: job, status: :created, serializer: JobsSerializer
          return
        end
        render_json_validation_error job, :validation_error
      end

      private

      def job_params
        params.permit(:empresa, :titulo, :descricao, :localizacao, :nivel)
      end
    end
  end
end
