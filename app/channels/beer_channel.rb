class BeerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "beer"
  end
end
