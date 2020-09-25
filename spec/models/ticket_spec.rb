require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'when required fields are valid' do
    it 'successfully creates an ticket type' do
      expect { FactoryBot.create(:ticket) }.to change { Ticket.count }.from(0).to(1)
    end

    it 'has an event associated' do
      event = FactoryBot.create(:event, name: 'custom event')
      ticket = FactoryBot.create(:ticket, event: event)

      expect(ticket.event).to_not be_nil
      expect(ticket.event.name).to eq(event.name)
    end
  end
end
