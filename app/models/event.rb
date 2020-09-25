class Event < ApplicationRecord
  validates :name, :date, :time, presence: true

  has_many :tickets
end
