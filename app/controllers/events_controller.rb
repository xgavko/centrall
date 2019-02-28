class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def show
    Participation.create(user: current_user, event: @event) if @event.boarding?
  end

  def index
    @restult = Result.where.not(latitude: nil, longitude: nil)

    @markers = @results.map do |result|
      {
        lng: result.longitude,
        lat: result.latitude
      }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
