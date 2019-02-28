class AddRefToParticipation < ActiveRecord::Migration[5.2]
  def change
    add_reference :participations, :place, foreign_key: true
  end
end
