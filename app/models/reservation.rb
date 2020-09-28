class Reservation < ApplicationRecord

  include Purchasable

  belongs_to :ticket

  enum status: %i[reserved paid expired]
  enum selling_option: %i[even all_together avoid_one]

  before_create :update_tickets
  before_save :set_expiring_datetime, :calculate_to_be_paid

  validates :quantity, :email, :selling_option, :ticket_id, presence: true
  validate :check_available_tickets, :check_selling_option

  scope :by_most_recent_email, ->(email) { self.where(email: email).last }

  def valid_reservation?
    self.valid_until.in_time_zone > DateTime.now.in_time_zone
  end

  def retrieve_amount
    self.to_be_paid
  end

  private

  def check_selling_option
    case self.selling_option
    when 'even'
      if self.quantity % 2 != 0
        errors.add(:quantity, 'You can only buy tickets on an even amount')
      end
    when 'all_together'
      if self.quantity != available_tickets
        errors.add(:quantity, 'You can only buy the total amount of tickets at once')
      end
    when 'avoid_one'
      if (self.quantity - available_tickets).abs == 1
        errors.add(:quantity, "You can't leave 1 ticket available")
      end
    end
  end

  def check_available_tickets
    tickets_available = available_tickets
    if self.quantity && tickets_available < self.quantity
      errors.add(:quantity, "There are: #{tickets_available} tickets available.")
    end
  end

  def available_tickets
    available_purchasable('Ticket', purchasable_params)
  end

  def update_tickets
    update_quantity('Ticket', purchasable_params)
  end

  def calculate_to_be_paid
    self.to_be_paid = calculate_total('Ticket', purchasable_params)
  end

  def set_expiring_datetime
    self.valid_until = DateTime.now.in_time_zone + 15.minutes
  end

  def purchasable_params
    { purchasable_id: self.ticket_id, purchasable_quantity: self.quantity }
  end
end
