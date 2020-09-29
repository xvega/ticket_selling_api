require 'rails_helper'

RSpec.describe Payment, type: :model do
  context 'validations' do

    let(:ticket) { FactoryBot.create(:ticket, quantity: 30) }
    let(:reservation) do
      FactoryBot.create(:reservation,
                        email: 'ringo@beatles.com',
                        valid_until: DateTime.now.in_time_zone + 15.minutes,
                        quantity: 2,
                        ticket_id: ticket.id)
    end
    let(:payment) do
      FactoryBot.build(:payment,
                       email: reservation.email,
                       amount: reservation.to_be_paid)
    end

    let(:invalid_payment) do
      FactoryBot.build(:payment,
                       email: 'nonexisting@mail.com',
                       amount: 13)
    end

    let(:stub_reservation) { double("reservation") }

    describe 'when required fields are valid' do

      it 'successfully creates a payment' do
        expect { payment.save }.to change { Payment.count }.from(0).to(1)
      end
    end

    describe 'when required fields are not valid' do
      it 'does not create a payment when reservation is invalid' do
        allow(invalid_payment).to receive(:reservation).and_return(stub_reservation)
        allow(stub_reservation).to receive(:retrieve_amount).and_return(nil)
        allow(stub_reservation).to receive(:valid_reservation?).and_return(false)


        expect { invalid_payment.save }.to_not(change { Payment.count })
        expect(invalid_payment.errors.messages[:payment]).to include("You can't pay for an expired reservation")
      end

      it 'does not create a payment when the amount does not match the reservation' do
        allow(invalid_payment).to receive(:reservation).and_return(stub_reservation)
        allow(stub_reservation).to receive(:retrieve_amount).and_return(invalid_payment.amount - 1)
        allow(stub_reservation).to receive(:valid_reservation?).and_return(true)


        expect { invalid_payment.save }.to_not change { Payment.count }
        expect(invalid_payment.errors.messages[:amount]).to include("Please enter the exact amount: #{invalid_payment.amount - 1}")
      end
    end


    describe 'reservation updates' do
      it 'updates the reservation status from reserved to paid' do
        expect { payment.save }.to change { reservation.reload.status }.from("reserved").to("paid")
      end
    end
  end
end
