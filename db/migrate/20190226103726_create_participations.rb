class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :status, default: 0
      t.string :address
      t.string :chosen_place

      t.timestamps
    end
  end
end
