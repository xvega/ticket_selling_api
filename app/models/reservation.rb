class Reservation < ApplicationRecord

  include Purchasable

  belongs_to :ticket

  enum status: %i[available reserved paid]
  enum selling_option: %i[even all_together avoid_one]

  before_create :update_tickets
  before_save :set_expiring_datetime, :calculate_to_be_paid, :update_status

  validates :quantity, :email, :selling_option, :ticket_id, presence: true
  validate :check_available_tickets

  private

  def check_available_tickets
    tickets_available = available_tickets
    if self.quantity && tickets_available < self.quantity
      errors.add(:quantity, "There are: #{tickets_available} tickets available.")
    end
  end

  def available_tickets
  byebug
    available_purchasable('Ticket', purchasable_params)
  end

  def update_tickets
  byebug
    update_quantity('Ticket', purchasable_params)
  end

  def calculate_to_be_paid
  byebug
    self.to_be_paid = calculate_total('Ticket', purchasable_params)
  end

  def set_expiring_datetime
    self.valid_until = DateTime.now + 15.minutes
  end

  def update_status
    self.status = 1
  end

  def purchasable_params
    { purchasable_id: self.ticket_id, purchasable_quantity: self.quantity }
  end
end
