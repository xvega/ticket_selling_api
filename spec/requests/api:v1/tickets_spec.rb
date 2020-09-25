require 'swagger_helper'

RSpec.describe 'Api::V1::Tickets', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/v1/tickets' do
    post 'Creates a ticket' do
      tags 'Tickets'
      consumes 'application/json'
      security [bearer: {}]
      parameter name: :ticket, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              description: { type: :string },
              quantity: { type: :integer },
              status: { type: :integer },
              price: { type: :float },
              event_id: { type: :integer }
          },
          required: [ 'name', 'quantity', 'price', 'status', 'event_id' ]
      }

      response '201', 'created' do
        let(:event) { FactoryBot.create(:event) }
        let(:ticket) do
          { name: 'VIP',
            price: 20.00,
            description: 'foo',
            quantity: 30,
            status: 0,
            event_id: event.id }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:ticket) { { name: '' } }
        run_test!
      end
    end
  end

  path '/v1/tickets' do
    get 'retrieves tickets' do
      tags 'Tickets'
      consumes 'application/json'
      security [bearer: {}]

      response '200', 'success' do
        let(:event) { FactoryBot.create(:event) }
        let(:ticket) { FactoryBot.create(:ticket, event_id: event.id) }
        run_test!
      end

      # response '204', 'no content' do
      #   run_test!
      # end
    end
  end
end
