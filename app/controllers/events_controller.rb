class EventsController < ApplicationController
  def index
    @events = Event.order(created_at: :desc)
    @events_today = @events.today

    @longest_press = @events.button_presses.order(duration: :desc).first.duration.to_f / 1000

    @presses_per_minute_today = @events_today.button_presses.count / ((Time.now - Time.now.beginning_of_day) / 60)

    @events_last_ten_minutes = Event.last_ten_minutes
    @presses_per_minute_last_ten_minutes = @events_last_ten_minutes.count / ((Time.now - (Time.now - 10.minutes)) / 60)

    @rankings = Event.group(:device_id).count.sort_by {|device_id, count| count}.reverse
  end

  def user
    @events = Event.where(device_id: params[:device_id]).order(created_at: :desc)
    @events_today = @events.today

    @longest_press = @events.button_presses.order(duration: :desc).first.duration.to_f / 1000

    @presses_per_minute_today = @events_today.button_presses.count / ((Time.now - Time.now.beginning_of_day) / 60)
  end

  def beer

  end
end
