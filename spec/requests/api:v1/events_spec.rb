require 'swagger_helper'

RSpec.describe 'Api::V1::Events', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/v1/events' do
    post 'Creates an event' do
      tags 'Events'
      security [{ Bearer: [] }]
      consumes 'application/json'
      parameter name: :event, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              description: { type: :string },
              date: { type: :string },
              time: { type: :string }
          },
          required: [ 'name', 'description', 'date', 'time' ]
      }

      response '201', 'created' do
        let(:event) { { name: 'foo', description: 'bar', date: '2020-09-24', time: '00:00:00' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:event) { { name: '' } }
        run_test!
      end
    end
  end

  path '/v1/events/{id}' do

    get 'Retrieves an Event' do
      tags 'Events'
      produces 'application/json'
      security [Bearer: {}]
      parameter name: :id, in: :path, type: :string

      response '200', 'event found' do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 description: { type: :string },
                 time: { type: :string },
                 date: { type: :string }
               }

        let(:id) { FactoryBot.create(:event).id }
        run_test!
      end

      response '404', 'event not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/events/' do
    get 'Retrieves a list of events' do
      tags 'Events'
      produces 'application/json'
      security [Bearer: {}]

      response '200', 'events found' do
        schema type: :object,
               properties: {
                   name: { type: :string },
                   description: { type: :string },
                   time: { type: :string },
                   date: { type: :string }
               }

        run_test!
      end
    end
  end
end
