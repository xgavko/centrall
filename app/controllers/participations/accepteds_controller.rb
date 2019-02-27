class Participations::AcceptedsController < ApplicationController
  def create
    participation = Participation.find(params[:participation_id])
    participation.address = participation_params[:address]
    participation.accepted!
    redirect_to participation.event
  end

  private

  def participation_params
    params.require(:participation).permit(:address, :participation_id)
  end
end
