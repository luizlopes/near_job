module Api
  module V1
    class JobCandidatesController < ApplicationController
      before_action :find_job, only: %i[ranking]

      def_param_group :job_candidate_record do
        param :id_vaga, Integer, 'Id da vaga', required: true
        param :id_pessoa, Integer, 'Id da pessoa', required: true
      end

      api :GET, '/v1/vagas/:vaga_id/candidaturas/ranking',
          'Rank dos candidatos a vaga'
      def ranking
        render json: @job.job_candidates, each_serializer: RankingSerializer
      end

      api :POST, '/v1/candidaturas', 'Cria uma nova candidatura'
      param_group :job_candidate_record
      def create
        job_candidate = JobCandidateService.new.create job_candidate_params
        if job_candidate.save job_candidate
          render json: job_candidate, status: :created,
                 serializer: RankingSerializer
          return
        end
        render_json_validation_error job_candidate, :validation_error
      end

      private

      def find_job
        @job = Job.find(params[:vaga_id])
      end

      def job_candidate_params
        { job_id: params[:id_vaga], person_id: params[:id_pessoa] }
      end
    end
  end
end
