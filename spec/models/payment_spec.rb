require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'when required fields are valid' do
    it 'successfully creates a payment' do
      expect { FactoryBot.create(:payment) }.to change { Payment.count }.from(0).to(1)
    end

    it 'has a ticket associated' do
      ticket = FactoryBot.create(:ticket, name: 'normal')
      payment = FactoryBot.create(:payment, ticket: ticket)

      expect(payment.ticket).to_not be_nil
      expect(payment.ticket.name).to eq(ticket.name)
    end
  end
end
