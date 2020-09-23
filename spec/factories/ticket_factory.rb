FactoryBot.define do
  factory :ticket do
    quantity { 3 }
    ticket_type
    owner_email { 'owner@mail.com' }
    owner_name { 'paul' }
    status { 0 }
  end
end