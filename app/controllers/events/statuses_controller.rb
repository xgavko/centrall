class Events::StatusesController < ApplicationController
  def update
    event = Event.find_by_slug(params[:slug])
    if event.boarding?
      event.status = :voting
    elsif event.voting?
      event.status = :display_result
    end
    event.save

    redirect_to event
  end
end
