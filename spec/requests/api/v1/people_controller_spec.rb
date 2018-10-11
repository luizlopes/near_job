require 'rails_helper'

RSpec.describe Api::V1::PeopleController do
  describe 'POST /v1/pessoas' do
    context 'sucessfully' do
      let(:luiz) do
        {
          nome: 'Luiz',
          profissao: 'Pedreiro',
          localizacao: 'A',
          nivel: 5
        }
      end

      before do
        post '/v1/pessoas', params: luiz
      end

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns person details' do
        person = Person.last
        expect(json_response[:id]).to eq(person.id)
        expect(json_response[:nome]).to eq(person.name)
        expect(json_response[:profissao]).to eq(person.career)
        expect(json_response[:localizacao]).to eq(person.localization)
        expect(json_response[:nivel]).to eq(person.level)
      end
    end

    context 'with empty fields' do
      let(:params_empty_fields) do
        {
        }
      end

      before do
        post '/v1/pessoas', params: params_empty_fields
      end

      it 'returns status code bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return error messages that fields cant be blank' do
        expect(json_response[:status]).to eq(400)
        expect(json_response[:title]).to eq('Validation error')
        expect(json_response[:detail]).to eq('Validation errors occurred')
        expect(json_response[:messages][:name][0]).to eq('can\'t be blank')
        expect(json_response[:messages][:career][0]).to eq('can\'t be blank')
        expect(json_response[:messages][:localization][0]).to eq('can\'t be '\
                                                                 'blank')
        expect(json_response[:messages][:level][0]).to eq('can\'t be blank')
      end
    end

    context 'with level under 1' do
      let(:luiz) do
        {
          nome: 'Luiz',
          profissao: 'Pedreiro',
          localizacao: 'A',
          nivel: 0
        }
      end

      before do
        post '/v1/pessoas', params: luiz
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

    context 'with level over than 5' do
      let(:luiz) do
        {
          nome: 'Luiz',
          profissao: 'Pedreiro',
          localizacao: 'A',
          nivel: 6
        }
      end

      before do
        post '/v1/pessoas', params: luiz
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
