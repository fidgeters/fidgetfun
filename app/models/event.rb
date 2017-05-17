class Event < ApplicationRecord
  extend Enumerize

  enumerize :event_type, in: [:button, :switch, :meter]

  after_save :pour_beer, if: -> { event_type == :button }

  def pour_beer
    ActionCable.server.broadcast 'beer', percentage: 5
  end
end
