class Event < ApplicationRecord
  validates :name, :date, :time, presence: true

  has_many :tickets

  before_save :format_time

  private

  def format_time
    self.time = self.time.change(day: self.date.day, month: self.date.month, year: self.date.year)
  end
end
