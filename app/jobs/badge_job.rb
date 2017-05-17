class BadgeJob < ApplicationJob
  def perform(device_id)
    BadgeCreator.new(device_id).calculate_badges
  end
end
