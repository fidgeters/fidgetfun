class Event < ApplicationRecord
  extend Enumerize

  enumerize :event_type, in: [:button, :switch, :meter]

  after_save :pour_beer, if: -> { event_type == :button }
  after_commit :create_badges

  def pour_beer
    ActionCable.server.broadcast 'beer', percentage: 5, pushes: Event.where(event_type: :button, created_at: 5.minutes.ago..Time.now).count
  end

  def create_badges
    BadgeJob.perform_later device_id
  end
end
