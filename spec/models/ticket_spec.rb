require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'validations' do
    describe 'when required fields are valid' do
      it 'successfully creates a ticket' do
        expect { FactoryBot.create(:ticket) }.to change { Ticket.count }.from(0).to(1)
      end

      it 'has an event associated' do
        event = FactoryBot.create(:event, name: 'custom event')
        ticket = FactoryBot.create(:ticket, event: event)

        expect(ticket.event).to_not be_nil
        expect(ticket.event.name).to eq(event.name)
      end
    end

    describe 'when required fields are not valid' do
      it 'does not create a ticket' do
        ticket = FactoryBot.build(:ticket, event: nil)
        expect { ticket.save }.to_not(change { Ticket.count })
      end
    end
  end

  context '#update_available_tickets' do

    let!(:ticket) { FactoryBot.create(:ticket, quantity: 10) }

    xit 'updates available ticket amount' do

    end
  end
end
