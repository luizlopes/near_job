require 'rails_helper'

RSpec.describe Api::V1::JobCandidatesController do
  describe 'GET /v1/vagas/:vaga_id/candidaturas/ranking' do
    let(:pizzaiolo) { create(:job, title: 'Pizzaiolo', description: 'SUPER-MASSA', level: 4, localization: 'Z') }

    let(:nico) { create(:person, name: 'Nico Pomodoro', localization: 'A') }
    let(:silvio) { create(:person, name: 'Silvio Milanesa', localization: 'C', professional_background: 'super-massa') }
    let(:catarina) { create(:person, name: 'Catarina', localization: 'B') }

    before do
      create(:link, source: 'A', target: 'Z', distance: 20)
      create(:link, source: 'B', target: 'Z', distance: 15)
      create(:link, source: 'C', target: 'Z', distance: 10)

      create(:distance_factor, initial: 0, final: 10, factor: 100)
      create(:distance_factor, initial: 11, final: 15, factor: 50)
      create(:distance_factor, initial: 16, final: 20, factor: 25)
      create(:distance_factor, initial: 21, final: 999, factor: 0)

      post '/v1/candidaturas', params: { "id_vaga": pizzaiolo.id, "id_pessoa": nico.id }
      post '/v1/candidaturas', params: { "id_vaga": pizzaiolo.id, "id_pessoa": silvio.id }
      post '/v1/candidaturas', params: { "id_vaga": pizzaiolo.id, "id_pessoa": catarina.id }
    end

    context 'sucessfully' do
      before do
        get "/v1/vagas/#{pizzaiolo.id}/candidaturas/ranking", headers: { 'Accept': 'application/vnd' }
      end

      context 'without professional background' do
        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end

        it 'returns all candidates' do
          expect(json_response.size).to eq(3)
        end

        it 'returns first candidate with highest score' do
          expect(json_response[0][:nome]).to eq(silvio.name)
          expect(json_response[0][:profissao]).to eq(silvio.career)
          expect(json_response[0][:localizacao]).to eq(silvio.localization)
          expect(json_response[0][:nivel]).to eq(3)
          expect(json_response[0][:score]).to eq(137)
        end

        it 'returns second candidate with highest score' do
          expect(json_response[1][:nome]).to eq(catarina.name)
          expect(json_response[1][:profissao]).to eq(catarina.career)
          expect(json_response[1][:localizacao]).to eq(catarina.localization)
          expect(json_response[1][:nivel]).to eq(3)
          expect(json_response[1][:score]).to eq(62)
        end

        it 'returns third candidate with highest score' do
          expect(json_response[2][:nome]).to eq(nico.name)
          expect(json_response[2][:profissao]).to eq(nico.career)
          expect(json_response[2][:localizacao]).to eq(nico.localization)
          expect(json_response[2][:nivel]).to eq(3)
          expect(json_response[2][:score]).to eq(49)
        end
      end
    end

    context 'when job does not exists' do
      before do
        get '/v1/vagas/0/candidaturas/ranking',
            headers: { 'Accept': 'application/vnd' }
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(json_response[:status]).to eq(404)
        expect(json_response[:title]).to eq('Could not find job')
        expect(json_response[:detail]).to eq('This job does not exist')
      end
    end
  end

  describe 'POST /v1/candidaturas' do
    let!(:link_from_a_to_b) { create :link }
    let!(:distance_factor) { create :distance_factor }

    let(:pizzaiolo) { create :job, title: 'Pizzaiolo', level: 4 }
    let(:nico) { create :person, name: 'Nico Pomodoro' }
    let(:mama) { create :person, name: 'Mama Bruschetta' }
    let(:nico_to_pizzaiolo_params) do
      {
        "id_vaga": pizzaiolo.id,
        "id_pessoa": nico.id
      }
    end
    let(:mama_to_pizzaiolo_params) do
      {
        "id_vaga": pizzaiolo.id,
        "id_pessoa": mama.id
      }
    end
    let(:not_valid_params) do
      {
        "id_vaga": 0,
        "id_pessoa": 0
      }
    end

    context 'sucessfully' do
      before do
        post '/v1/candidaturas', params: nico_to_pizzaiolo_params
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns job candidate details' do
        expect(json_response[:nome]).to eq(nico.name)
        expect(json_response[:profissao]).to eq(nico.career)
        expect(json_response[:localizacao]).to eq(nico.localization)
        expect(json_response[:nivel]).to eq(nico.level)
      end
    end

    context 'when job id does not exists' do
      before do
        post '/v1/candidaturas', params: not_valid_params
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return error message' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:job][0]).to eq('must exist')
      end
    end

    context 'when person id does not exists' do
      before do
        post '/v1/candidaturas', params: not_valid_params
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return error message' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:person][0]).to eq('must exist')
      end
    end

    context 'when a person candidates to same job two times' do
      let!(:nico_pizzaiolo) do
        create :job_candidate, job: pizzaiolo, person: nico, score: 30
      end

      before do
        post '/v1/candidaturas', params: nico_to_pizzaiolo_params
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return error message' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:person][0]).to eq('has already '\
                                                           'been taken')
      end
    end

    context 'when two persons candidates to same job' do
      let!(:nico_pizzaiolo) do
        create :job_candidate, job: pizzaiolo, person: nico, score: 30
      end

      before do
        post '/v1/candidaturas', params: mama_to_pizzaiolo_params
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end
  end
end
