class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :valid_until, :status, :selling_option, :email, :quantity, :to_be_paid, :ticket_id
end
