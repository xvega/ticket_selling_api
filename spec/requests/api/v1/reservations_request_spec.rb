require 'rails_helper'

RSpec.describe "Api::V1::Reservations", type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:headers) do
    { 'ACCEPT' => 'application/json', 'Authorization': "Bearer #{access_token}" }
  end

  describe 'POST /v1/reservations' do

    let(:ticket) { FactoryBot.create(:ticket) }

    let(:reservation_test) do
      { "valid_until"=>"2020-09-29T13:59:55.000+02:00",
        "status"=>"reserved",
        "selling_option"=>"even",
        "email"=>"ringo@beatles.com",
        "quantity"=>2,
        "to_be_paid"=>40.0,
        "ticket_id"=>1
      }

    end

    describe 'when params are valid' do

      let(:valid_params) do
        { reservation:
              {
                "email": "ringo@beatles.com",
                "quantity": 2,
                "ticket_id": ticket.id,
                "selling_option": "even"
              }
        }
      end

      it 'returns a reservation' do
        post '/v1/reservations', params: valid_params, headers: headers
        expect(JSON.parse(response.body)['data']['id']).to_not be_nil

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when params are invalid' do

      let(:invalid_params) do
        { reservation:
          {
              "email": "",
              "quantity": 2,
              "ticket_id": '',
              "selling_option": "even"
          }
        }
      end

      it 'returns an error' do
        post '/v1/reservations', params: invalid_params, headers: headers
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /v1/reservations/' do

    describe 'when records exist' do

      let!(:reservation_1) { FactoryBot.create(:reservation) }
      let!(:reservation_2) { FactoryBot.create(:reservation) }
      let!(:reservation_3) { FactoryBot.create(:reservation) }

      it 'returns events' do
        get "/v1/reservations/", headers: headers
        expect(JSON.parse(response.body)).to_not be_empty
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['data'].count).to eq(3)
      end
    end

    describe 'when there are no records' do

      it 'returns an empty array' do
        get "/v1/reservations/", headers: headers
        expect(JSON.parse(response.body)).to_not be_empty
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['data'].count).to eq(0)
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end
  end

  describe 'GET /v1/reservations/:id' do

    describe 'when a record exists' do

      let(:reservation) { FactoryBot.create(:reservation) }

      it 'returns a reservation' do
        get "/v1/reservations/#{reservation.id}", headers: headers
        expect(JSON.parse(response.body)['data']['attributes']).to_not be_empty
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:success)
        expect( JSON.parse(response.body)['data']['id']).to eq(reservation.id.to_s)
      end
    end

    describe 'when a record does not exist' do
      it 'returns an empty array' do
        reservation_id = 666
        get "/v1/reservations/#{reservation_id}", headers: headers
        event_response = JSON.parse(response.body)['data']
        expect(event_response).to eq(nil)
      end
    end
  end

end
