class Ticket < ApplicationRecord
  belongs_to :event

  validates :name, :price, :quantity, :status, :event, presence: true
end
