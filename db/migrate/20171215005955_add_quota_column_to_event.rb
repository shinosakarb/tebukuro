class AddQuotaColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :quota, :integer, null: false
  end
end
