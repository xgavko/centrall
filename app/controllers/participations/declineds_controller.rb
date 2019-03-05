class Participations::DeclinedsController < ApplicationController
  def create
    @participation = Participation.find(params[:participation_id])
    @participation.address = nil
    @participation.status = :declined
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

    redirect_to @participation.event
  end
end
