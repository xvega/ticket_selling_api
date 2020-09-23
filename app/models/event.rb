class Event < ApplicationRecord
  validates :name, :date, :time, presence: true
end
