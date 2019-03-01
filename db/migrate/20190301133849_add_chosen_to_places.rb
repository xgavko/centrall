class AddChosenToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :chosen, :boolean
  end
end
