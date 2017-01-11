class AddDetailToEvents < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.datetime :invitation_starts_at, :null => false
      t.datetime :invitation_ends_at, :null => false
      t.datetime :event_starts_at, :null => false
      t.datetime :event_ends_at, :null => false
    end
  end
end
