class RemoveChosenPlaceInParticipations < ActiveRecord::Migration[5.2]
  def change
    remove_column :participations, :chosen_place
  end
end
