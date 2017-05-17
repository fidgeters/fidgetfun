class Api::EventsController < Api::BaseController
  def create

    params["events"].each do |event|
      event = Event.create(
        event_type: event["type"],
        value: event["value"],
        pressed_at: event["pressed_at"],
        duration: event["duration"]
        )
    end

    render_succes
  end

  def render_succes
    render json: { message: 'Success', params: params }
  end

  def render_error
    render json: { message: 'Fail', params: params }
  end
end
