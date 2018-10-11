require 'rails_helper'

RSpec.describe Api::V1::JobsController do
  describe 'POST /v1/vagas' do
    context 'sucessfully' do
      let(:job_pedreiro) do
        {
          empresa: 'Teste',
          titulo: 'Vaga teste',
          descricao: 'Criar os mais diferentes tipos de teste',
          localizacao: 'A',
          nivel: 5
        }
      end

      before do
        post '/v1/vagas', params: job_pedreiro
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns job details' do
        job = Job.last
        expect(json_response[:id]).to eq(job.id)
        expect(json_response[:empresa]).to eq(job.company)
        expect(json_response[:titulo]).to eq(job.title)
        expect(json_response[:descricao]).to eq(job.description)
        expect(json_response[:localizacao]).to eq(job.localization)
        expect(json_response[:nivel]).to eq(job.level)
      end
    end

    context 'with empty fields' do
      let(:params_empty_fields) do
        {
          empresa: '',
          titulo: '',
          descricao: '',
          localizacao: '',
          nivel: 1
        }
      end

      before do
        post '/v1/vagas', params: params_empty_fields
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return error messages that fields cant be blank' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:company][0]).to eq('can\'t be blank')
        expect(json_response[:messages][:title][0]).to eq('can\'t be blank')
        expect(json_response[:messages][:description][0]).to eq('can\'t be '\
                                                                'blank')
        expect(json_response[:messages][:localization][0]).to eq('can\'t be '\
                                                                 'blank')
      end
    end

    context 'with level under 1' do
      let(:job_pedreiro) do
        {
          empresa: 'Teste',
          titulo: 'Vaga teste',
          descricao: 'Criar os mais diferentes tipos de teste',
          localizacao: 'A',
          nivel: 0
        }
      end

      before do
        post '/v1/vagas', params: job_pedreiro
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for level out of range' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:level][0]).to eq('is not included '\
                                                          'in the list')
      end
    end

    context 'with level above 5' do
      let(:job_pedreiro) do
        {
          empresa: 'Teste',
          titulo: 'Vaga teste',
          descricao: 'Criar os mais diferentes tipos de teste',
          localizacao: 'A',
          nivel: 6
        }
      end

      before do
        post '/v1/vagas', params: job_pedreiro
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for level out of range' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:level][0]).to eq('is not included '\
                                                          'in the list')
      end
    end
  end
end
