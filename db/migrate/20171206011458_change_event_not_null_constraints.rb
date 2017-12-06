class ChangeEventNotNullConstraints < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :event_starts_at, :datetime, null: true
    change_column :events, :event_ends_at, :datetime, null: true
  end
end
