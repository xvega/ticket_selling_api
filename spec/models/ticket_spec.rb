require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'when required fields are valid' do
    it 'successfully creates an ticket type' do
      expect { FactoryBot.create(:ticket) }.to change { Ticket.count }.from(0).to(1)
    end

    it 'has an ticket type associated' do
      ticket_type = FactoryBot.create(:ticket_type)
      ticket = FactoryBot.create(:ticket, ticket_type: ticket_type)

      expect(ticket.ticket_type).to_not be_nil
      expect(ticket.ticket_type.name).to eq(ticket_type.name)
    end
  end
end
