FactoryBot.define do
  factory :event do
    name { "Paul McCartney Concert" }
    description  { "Event Description" }
    date { '10/10/1980' }
    time { '10:00:00' }
  end
end