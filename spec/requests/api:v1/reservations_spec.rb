require 'swagger_helper'

RSpec.describe 'Api::V1::Reservations', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/v1/reservations' do
    post 'Creates a reservation' do
      tags 'Tickets'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              quantity: { type: :string },
              ticket_id: { type: :integer },
              selling_option: { type: :integer }
          },
          required: [ 'email', 'quantity', 'ticket_id', 'selling_option' ]
      }

      response '201', 'created' do
        let(:ticket) { FactoryBot.create(:ticket) }
        let(:reservation) do
          { email: 'ringo@beatles.com',
            quantity: 2,
            selling_option: 1,
            ticket_id: ticket.id }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { email: '' } }
        run_test!
      end
    end
  end
end
