class EventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event-#{params[:event_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
