class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def show
    Participation.create(user: current_user, event: @event) if @event.boarding?
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
