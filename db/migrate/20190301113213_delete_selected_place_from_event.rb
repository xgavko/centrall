class DeleteSelectedPlaceFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :selected_place
  end
end
