class Ticket < ApplicationRecord
  belongs_to :event

  validates :name, :price, :quantity, :status, :event, presence: true

  scope :by_event, ->(event_id) { self.where(event_id: event_id) }
  scope :find_price, ->(id) { self.find_by(id: id)&.price }
  scope :available_per_type, ->(id) { self.find_by(id: id)&.quantity.to_i }

  def self.update_available_tickets(id, sub_amount)
    ticket = Ticket.find_by(id: id)
    new_quantity = ticket.quantity - sub_amount
    ticket.update!(quantity: new_quantity)
  end
end
