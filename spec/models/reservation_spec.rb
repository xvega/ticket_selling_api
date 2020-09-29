require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context 'validations' do
    let(:ticket) { FactoryBot.create(:ticket, name: 'normal', quantity: 20) }

    describe 'when required fields are valid' do
      it 'successfully creates an reservation' do
        expect { FactoryBot.create(:reservation) }.to change { Reservation.count }.from(0).to(1)
      end

      it 'has a ticket associated' do
        reservation =  FactoryBot.create(:reservation, ticket: ticket)

        expect(reservation.ticket).to_not be_nil
        expect(reservation.ticket.name).to eq(ticket.name)
      end

      it 'fails when there is no email' do
        reservation =  FactoryBot.build(:reservation, ticket: ticket, email: nil)

        expect { reservation.save }.to_not change { Reservation.count }
        reservation.save
        expect(reservation.errors.messages[:email]).to include("can't be blank")
      end

      it 'fails when there is no quantity' do
        reservation = FactoryBot.build(:reservation, ticket: ticket, quantity: nil)

        expect { reservation.save }.to_not change { Reservation.count }
        reservation.save
        expect(reservation.errors.messages[:quantity]).to include("can't be blank")
      end
    end

    describe '#check_selling_option' do
      describe 'when the quantity matches a selling option' do
        let(:reservation) do
          FactoryBot.build(:reservation, ticket: ticket, quantity: 10, selling_option: 'even')
        end

        it 'creates the reservation' do
          expect { reservation.save }.to change { Reservation.count }
        end
      end

      describe 'when the quantity does not match a selling option' do
        let(:reservation) do
          FactoryBot.build(:reservation, ticket: ticket, quantity: 10, selling_option: 'all_together')
        end

        it 'does not create a reservation' do
          expect { reservation.save }.to_not change { Reservation.count }
          reservation.save
          expect(reservation.errors.messages[:quantity]).to include('You can only buy the total amount of tickets at once')
        end
      end
    end

    describe '#check_available_tickets' do
      let(:reservation) do
        FactoryBot.build(:reservation, ticket: ticket, quantity: 6, selling_option: 'even')
      end

      describe 'when there are tickets available' do
        it 'creates a reservation' do
          allow(reservation).to receive(:available_tickets).and_return(30)

          expect { reservation.save }.to change { Reservation.count }.from(0).to(1)
        end
      end

      describe 'when there are no tickets available' do
        it 'does not create a reservation' do
          allow(reservation).to receive(:available_tickets).and_return(2)

          expect { reservation.save }.to_not change { Reservation.count }
        end
      end
    end
  end
end
