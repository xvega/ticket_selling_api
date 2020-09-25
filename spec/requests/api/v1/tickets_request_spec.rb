require 'rails_helper'

RSpec.describe "Api::V1::Tickets", type: :request do

  describe 'POST /v1/tickets' do
    
    let(:event_id) { FactoryBot.create(:event).id }

    let(:ticket_test) do
      {'name'=>'VIP',
       'description'=>'desc',
       'quantity'=>20,
       'price'=>30.00,
       'status'=>0,
       'event_id'=>event_id}
    end

    describe 'when params are valid' do

      let(:valid_params) do
        { ticket:
              {name:'VIP',
               description: 'desc',
               quantity: 20,
               price: 30.00,
               status: 0,
               event_id: event_id}}
      end

      it 'returns a ticket' do
        post '/v1/tickets', params: valid_params, headers: headers
        expect(JSON.parse(response.body)['data']['attributes']).to eq(ticket_test)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when params are invalid' do

      let(:invalid_params) do
        { ticket:
              { name: '',
                price: '',
                quantity: '',
                status: '',
                event_id: ''}}
      end

      it 'returns an error' do
        post '/v1/tickets', params: invalid_params, headers: headers
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
