class AddEventColumns < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :community, index: true
  end
end
