FactoryBot.define do
  factory :ticket_type do
    name { "VIP" }
    description  { "Expensive tickets" }
    price { 30.00 }
    event
  end
end