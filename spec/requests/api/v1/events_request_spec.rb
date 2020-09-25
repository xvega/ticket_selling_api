require 'rails_helper'

RSpec.describe 'Api::V1::Events', type: :request do

  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end

  describe 'POST /v1/events' do
    
    let(:event_test) do
      {'name'=>'test_name',
       'description'=>'desc',
       'date'=>'2020-09-24',
       'time'=>'2000-01-01T00:00:00.000Z'
      }
    end

    describe 'when params are valid' do

      let(:valid_params) do
        { event:
              { name: 'test_name',
                description: 'desc',
                date: '2020-09-24',
                time: '00:00:00' }
        }
      end

      it 'returns an event' do
        post '/v1/events', params: valid_params, headers: headers
        expect(JSON.parse(response.body)['data']['attributes']).to eq(event_test)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when params are invalid' do

      let(:invalid_params) do
        { event:
              { name: '',
                description: '',
                date: '',
                time: '' }
        }
      end

      it 'returns an error' do
        post '/v1/events', params: invalid_params, headers: headers
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /v1/events/:id' do

    describe 'when a record exists' do

      let(:event) { FactoryBot.create(:event) }

      it 'returns an event' do
        get "/v1/events/#{event.id}", headers: headers
        expect(JSON.parse(response.body)['data']['attributes']).to_not be_empty
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when a record does not exist' do
      it 'returns an error message' do
        event_id = 666
        get "/v1/events/#{event_id}", headers: headers
        error_message = { "message" => "Couldn't find Event with 'id'=#{event_id}" }
        event_response = JSON.parse(response.body)
        expect(event_response).to eq(error_message)
      end
    end
  end
end
