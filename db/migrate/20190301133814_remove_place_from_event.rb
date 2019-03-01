class RemovePlaceFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_reference :events, :place, foreign_key: true
  end
end
