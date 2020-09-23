require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'when required fields are valid' do
    it 'successfully creates an reservation' do
      expect { FactoryBot.create(:reservation) }.to change { Reservation.count }.from(0).to(1)
    end

    it 'has a ticket associated' do
      ticket = FactoryBot.create(:ticket, owner_email: 'owner@mail.com')
      reservation = FactoryBot.create(:reservation, ticket: ticket)

      expect(reservation.ticket).to_not be_nil
      expect(reservation.ticket.owner_email).to eq(ticket.owner_email)
    end
  end
end
