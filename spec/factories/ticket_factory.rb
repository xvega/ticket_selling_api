FactoryBot.define do
  factory :ticket do
    type { 'VIP' }
    quantity { 3 }
    price { 20.00 }
    description { 'If you want to spend cash, this is your choice!!' }
    status { 0 }
    event
  end
end