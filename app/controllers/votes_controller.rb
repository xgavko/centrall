class VotesController < ApplicationController
  def create
    participation = current_user.participations.find(params[:participation_id])
    participation.place = participation.event.places.find(params.dig(:vote, :place_id))
    participation.save

    redirect_to event_path(participation.event)
  end

end
