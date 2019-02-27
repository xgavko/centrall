class Participations::AcceptedsController < ApplicationController
  def create
    participation = Participation.find(params[:participation_id])
    participation.accepted!
    redirect_to participation.event
  end
end
