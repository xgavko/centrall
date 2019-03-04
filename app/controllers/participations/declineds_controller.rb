class Participations::DeclinedsController < ApplicationController
  def create
    participation = Participation.find(params[:participation_id])
    participation.address = nil
    participation.status = :declined
    participation.save

    redirect_to participation.event
  end
end
