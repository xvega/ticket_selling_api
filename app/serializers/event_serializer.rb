class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :date, :time
end
