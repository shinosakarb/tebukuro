class AddStartAndEndTimeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :started_at, :datetime
    add_column :events, :ended_at, :datetime
  end
end
