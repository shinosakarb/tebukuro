class AddCheckedInColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :status, :integer, default: 0
  end
end
