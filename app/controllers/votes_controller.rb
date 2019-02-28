class VotesController < ApplicationController
  def create
    participation = Participation.find(params["participation_id"].to_i)
    redirect_to event_path(participation.event)
  end
end
