require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'validations' do

    describe 'when required fields are valid' do
      it 'successfully creates an event' do
        expect { FactoryBot.create(:event) }.to change { Event.count }.from(0).to(1)
      end
    end

    describe 'when required fields are invalid' do

      let(:invalid_event) { FactoryBot.build(:event, name: nil) }

      it 'does not create an event' do
        expect do
          invalid_event.save
          expect(invalid_event.errors.messages[:name]).to include("can't be blank")
        end.to change { Event.count }.by(0)
      end
    end
  end
end

