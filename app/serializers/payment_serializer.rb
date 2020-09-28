class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount, :token, :ticket_id, :currency
end
