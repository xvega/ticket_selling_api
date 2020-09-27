FactoryBot.define do
  factory :reservation do
    valid_until { '' }
    status { 0 }
    selling_option { 0 }
    email { 'ringo@beatles.com' }
    quantity { 2 }
    to_be_paid { 20.00 }
    ticket
  end
end
