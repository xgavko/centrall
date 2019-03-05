class ParticipationsController < ApplicationController
  #layout 'pages_home', only: [:index]

  def index
    @participations = Participation.where(user_id: current_user)
  end
end
