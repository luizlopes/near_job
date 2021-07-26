require 'swagger_helper'

RSpec.describe 'api/v1/job_candidates', type: :request do

  before do
    create(:link, source: 'A', target: 'Z', distance: 20)
    create(:link, source: 'B', target: 'Z', distance: 15)
    create(:link, source: 'C', target: 'Z', distance: 10)

    create(:distance_factor, initial: 0, final: 10, factor: 100)
    create(:distance_factor, initial: 11, final: 15, factor: 50)
    create(:distance_factor, initial: 16, final: 20, factor: 25)
    create(:distance_factor, initial: 21, final: 999, factor: 0)
  end

  path '/v1/vagas/{vaga_id}/candidaturas/ranking' do
    get('ranking job_candidate') do
      consumes "application/json"
      parameter name: 'vaga_id', in: :path, type: :string, description: 'vaga_id'

      response(200, 'successful') do
        schema type: :array,
          properties: {
            nome: { type: :string },
            profissao: { type: :string },
            localizacao: { type: :string },
            nivel: { type: :integer },
            score: { type: :integer }
          },
          required: [ 'nome', 'profissao', 'localizacao', 'nivel', 'score' ]

        examples 'application/json' => [{
          nome: 'Nico Pomodoro',
          profissao: 'Chef Pizzaiolo',
          localizacao: 'A',
          nivel: 3,
          score: 99
        }]

        let(:vaga_id) { vaga.id }
        let(:vaga) { create(:job, title: 'Pizzaiolo', description: 'SUPER-MASSA', level: 4, localization: 'Z') }
        let(:candidato) { create(:person, name: 'Nico Pomodoro', localization: 'A') }
        let!(:vaga_candidato) { create(:job_candidate, job: vaga, person: candidato, score: 99) }

        let(:expected_response) {
          [{
            nome: 'Nico Pomodoro',
            profissao: 'Chef Pizzaiolo',
            localizacao: 'A',
            nivel: 3,
            score: 99
          }]
        }

        before do |example|
          submit_request(example.metadata)
        end

        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end

        it 'returns the expected response body' do
          expect(response.body).to eq(expected_response.to_json)
        end
      end
    end
  end

  path '/v1/candidaturas' do
    post('create job_candidate') do
      consumes "application/json"
      parameter name: :job_candidate, in: :body, schema: {
        type: :object,
        properties: {
          id_vaga: { type: :integer, example: 1 },
          id_pessoa: { type: :integer, example: 1 }
        },
        required: [ 'id_vaga', 'id_pessoa' ]
      }

      response(201, 'successful') do
        let(:job_candidate) { { id_vaga: vaga.id, id_pessoa: candidato.id } }
        let(:id_vaga) { vaga.id }
        let(:vaga) { create(:job, title: 'Pizzaiolo', description: 'SUPER-MASSA', level: 4, localization: 'Z') }
        let(:candidato) { create(:person, name: 'Nico Pomodoro', localization: 'A') }

        before do |example|
          submit_request(example.metadata)
        end

        it 'returns a valid 201 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end

      response('400', 'invalid request') do
        let(:job_candidate) { { id_vaga: 0, id_pessoa: candidato.id } }
        let(:id_vaga) { vaga.id }
        let(:vaga) { create(:job, title: 'Pizzaiolo', description: 'SUPER-MASSA', level: 4, localization: 'Z') }
        let(:candidato) { create(:person, name: 'Nico Pomodoro', localization: 'A') }

        before do |example|
          submit_request(example.metadata)
        end

        it 'returns a valid 201 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
