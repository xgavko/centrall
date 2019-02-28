class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :google_id
      t.string :name
      t.string :rating, default: 0
      t.string :address
      t.string :photo
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
