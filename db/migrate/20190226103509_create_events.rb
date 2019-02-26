class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.date :start_at
      t.integer :status, default: 0
      t.string :kind
      t.string :selected_place
      t.string :name

      t.timestamps
    end
  end
end
