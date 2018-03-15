class RemoveNameFromParticipant < ActiveRecord::Migration[5.1]
  def change
    remove_column :participants, :name, :string
  end
end
