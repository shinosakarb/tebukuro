class AddStartAndEndTimeToEvents < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
