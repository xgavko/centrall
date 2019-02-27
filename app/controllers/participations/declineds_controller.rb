class Participations::DeclinedsController < ApplicationController
  def create
    participation = Participation.find(params[:participation_id])
    participation.address = nil
    participation.declined!
    redirect_to participation.event
  end
end
