class AddCoordinatesToParticipations < ActiveRecord::Migration[5.2]
  def change
    add_column :participations, :latitude, :float
    add_column :participations, :longitude, :float
  end
end
