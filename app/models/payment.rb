class Payment < ApplicationRecord
  belongs_to :ticket

  after_save :update_reservation

  validates :amount, :email, presence: true
  validate :valid_reservation, :valid_amount, :find_reservation

  private

  # FIXME: smelly code
  def reservation
    @reservation ||= Reservation.by_most_recent_email(self.email)
  end

  def update_reservation
    reservation.paid!
  end

  def find_reservation
    return unless reservation.nil?

    errors.add(:payment, 'There is no reservation for the provided email')
  end

  def valid_amount
    reservation_total = reservation&.retrieve_amount
    return unless reservation && (self.amount != reservation_total)

    errors.add(:amount, "Please enter the exact amount: #{reservation_total}")
  end

  def valid_reservation
    return if reservation&.valid_reservation?

    errors.add(:payment, "You can't pay for an expired reservation")
  end
end
