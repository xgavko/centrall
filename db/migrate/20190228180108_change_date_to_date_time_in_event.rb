class ChangeDateToDateTimeInEvent < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :start_at, :datetime
  end
end
