class AddDetailToEvents < ActiveRecord::Migration[5.0]
  def change
<<<<<<< HEAD
<<<<<<< HEAD
    change_table :events, :null=>false do |t|
=======
    change_table :events do |t|
>>>>>>> e9aec92... ADD event_detail_information
=======
    change_table :events, :null=>false do |t|
>>>>>>> c4cdea2... FIX_2 add event_detail_information
      t.datetime :invitation_starts_at
      t.datetime :invitation_ends_at
      t.datetime :event_starts_at
      t.datetime :event_ends_at
      t.integer :number_of_accepted_participants
      t.integer :cost
    end
  end
end
