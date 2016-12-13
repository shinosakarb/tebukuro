class AddDetailToEvents < ActiveRecord::Migration[5.0]
  def change
<<<<<<< 32ff1bed124921c00ada3b6a7072a9e9e4115635
    change_table :events, :null=>false do |t|
=======
    change_table :events do |t|
>>>>>>> ADD event_detail_information
      t.datetime :invitation_starts_at
      t.datetime :invitation_ends_at
      t.datetime :event_starts_at
      t.datetime :event_ends_at
      t.integer :number_of_accepted_participants
      t.integer :cost
    end
  end
end
