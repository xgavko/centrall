class VotesController < ApplicationController
  def create
    @participation = current_user.participations.find(params[:participation_id])

    @old_place = @participation.place if @participation.place

    @place = @participation.event.places.find(params.dig(:vote, :place_id))
    @participation.place = @place
    @participation.save

    respond_to do |format|
      format.js # render votes/create.js.erb
    end
  end
end
