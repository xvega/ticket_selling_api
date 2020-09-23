require 'rails_helper'

RSpec.describe TicketType, type: :model do
  context 'validations' do

    describe 'when required fields are valid' do
      it 'successfully creates a ticket type' do
        expect { FactoryBot.create(:ticket_type) }.to change { TicketType.count }.from(0).to(1)
      end

      it 'has an event associated' do
        event = FactoryBot.create(:event, name: 'New Event')
        ticket_type = FactoryBot.create(:ticket_type, event: event)

        expect(ticket_type.event).to_not be_nil
        expect(ticket_type.event.name).to eq(event.name)
      end
    end
  end
end
