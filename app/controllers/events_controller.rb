class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def show
    if @event.created_at + 30.minutes < Time.current
      @event.display_result!
    elsif @event.created_at + 15.minutes < Time.current
      @event.voting!
    end

    case @event.status
    when "boarding"
      Participation.create(user: current_user, event: @event)
    when "voting"
      @event.set_places unless @event.places.any?
    when "display_result"
      @event.final_result
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
