class Event < ApplicationRecord
  extend Enumerize

  enumerize :event_type, in: [:button, :switch, :meter]

  after_save :pour_beer, if: -> { event_type == :button }

  scope :button_presses, -> { where("events.event_type = ?", 'button') }
  scope :today, -> { where(created_at: (Time.now.beginning_of_day..Time.now)) }
  scope :last_ten_minutes, -> { where(created_at: ((Time.now - 10.minutes)..Time.now)) }

  def pour_beer
    ActionCable.server.broadcast 'beer', percentage: 5, pushes: Event.where(event_type: :button, created_at: 5.minutes.ago..Time.now).count
  end
end
