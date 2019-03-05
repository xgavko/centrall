class Participations::AcceptedsController < ApplicationController
  def create
    @participation = Participation.find(params[:participation_id])
    @participation.address = participation_params[:address]
    @participation.status = :accepted
    @participation.save

    ActionCable.server.broadcast(
      "event-#{@participation.event.id}",
      {
        type: 'update_participation',
        participation_id: @participation.id,
        html: ApplicationController.render(
          partial: 'participations/participation',
          locals: { participation: @participation }
        )
      }
    )

    respond_to do |format|
      format.js # participations/accepteds/create.js
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:address)
  end
end
