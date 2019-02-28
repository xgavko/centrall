class VotesController < ApplicationController
  def create
    participation = Participation.find(params["participation_id"].to_i)
    # place = sdlkfj
    # parcicipation.place = place creer table places
    # participation.save

    redirect_to event_path(participation.event)
  end
end
