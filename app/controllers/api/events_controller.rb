class Api::EventsController < Api::BaseController
  def create
    event = Event.new(
      event_type: params["type"],
      value: params["value"],
      pressed_at: params["pressed_at"],
      duration: params["duration"]
      )

    if event.save
      render_succes
    else
      render_error
    end
  end

  def render_succes
    render json: { message: 'Success', params: params }
  end

  def render_error
    render json: { message: 'Fail', params: params }
  end
end
