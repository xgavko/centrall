class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def show
    case @event.status
    when "boarding"
      if @event.created_at + 1.minutes < Time.current
        if @event.process_barycenter.nil?
          # destroy event
          return
        end
        @event.voting!
        redirect_to event_path(@event)
      end
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
      first_cond = @event.participations.where(status: :accepted).count == @event.participations.where.not(place: nil).count
      second_cond = @event.updated_at + 15.minutes < Time.current
      if first_cond || second_cond
        @event.display_result!
        redirect_to event_path(@event)
      end
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
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :kind)
  end

  def set_event
    @event = Event.find_by_slug(params[:slug])
  end
end
