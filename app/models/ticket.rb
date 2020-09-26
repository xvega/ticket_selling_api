class Ticket < ApplicationRecord
  belongs_to :event

  validates :name, :price, :quantity, :status, :event, presence: true

  scope :by_event, ->(event_id) { Ticket.where(event_id: event_id) }
end
