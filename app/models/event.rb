class Event < ApplicationRecord
  extend Enumerize

  enumerize :event_type, in: [:button, :switch, :meter]
end
