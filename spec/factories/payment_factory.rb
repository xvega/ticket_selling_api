FactoryBot.define do
  factory :payment do
    amount { 30.00 }
    token  { "very_long_token" }
    currency { 'euro' }
    ticket
  end
end
