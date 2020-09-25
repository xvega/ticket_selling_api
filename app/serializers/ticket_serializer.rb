class TicketSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :quantity, :description, :status, :price, :event_id
end
