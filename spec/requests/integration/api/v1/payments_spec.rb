require 'swagger_helper'

RSpec.describe 'Api::V1::Payments', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/v1/payments' do
    post 'Creates a payment' do
      tags 'Payments'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :payment, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              amount: { type: :string },
              token: { type: :integer }
          },
          required: [ 'email', 'amount']
      }

      response '201', 'created' do
        let(:ticket) { FactoryBot.create(:ticket, quantity: 20) }
        let(:reservation) do
          FactoryBot.create(:reservation, email: 'ringo@beatles.com',
                            quantity: 2,
                            selling_option: 0,
                            ticket_id: ticket.id,
                            valid_until: (DateTime.now.in_time_zone + 15.minutes))
        end
        let(:payment) do
          { email: 'ringo@beatles.com',
            amount: reservation.to_be_paid,
            token: '',
            ticket_id: ticket.id}
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:payment) { { email: '' } }
        run_test!
      end
    end
  end
end
