class AddOrganizerIdColumn < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :organizer, foreign_key: { to_table: :users }
  end
end
