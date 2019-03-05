class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def show
    # if @event.created_at + 30.minutes < Time.current
    #   @event.display_result!
    # elsif @event.created_at + 15.minutes < Time.current
    #   @event.voting!
    # end

    case @event.status
    when "boarding"
      unless Participation.where(user: current_user, event: @event).exists?
        participation = Participation.create!(user: current_user, event: @event)
        ActionCable.server.broadcast(
          "event-#{@event.id}",
          {
            type: 'new_participation',
            html: ApplicationController.render(
              partial: 'participations/participation',
              locals: { participation: participation }
            )
          }
        )
      end
    when "voting"
      @event.set_places unless @event.places.any?

      @markers = @event.places.map do |place|
        {
          lat: place.latitude,
          lng: place.longitude
        }
      end
      @center = @event.process_barycenter.reverse

    when "display_result"
      @event.final_result!
    end
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.events.new(event_params)
    if event.save
      redirect_to event
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :kind)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
