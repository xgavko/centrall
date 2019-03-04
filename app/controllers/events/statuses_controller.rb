class Events::StatusesController < ApplicationController
  def update
    event = Event.find(params[:event_id])
    event.status = :voting
    event.save
    redirect_to event
  end
end
