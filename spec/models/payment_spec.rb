require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'when required fields are valid' do
    it 'successfully creates a payment' do
      ticket = FactoryBot.create(:ticket, quantity: 30)
      reservation = FactoryBot.create(:reservation,
                                      email: 'ringo@beatles.com',
                                      valid_until: DateTime.now.in_time_zone + 15.minutes,
                                      quantity: 2,
                                      ticket_id: ticket.id)
      payment = FactoryBot.build(:payment,
                                  email: reservation.email,
                                  amount: reservation.to_be_paid)

      expect { payment.save }.to change { Payment.count }.from(0).to(1)
    end
  end
end
