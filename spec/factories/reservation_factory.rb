FactoryBot.define do
  factory :reservation do
    valid_time { "00:15:00" }
    status { 0 }
    selling_option { 'even' }
    ticket
  end
end