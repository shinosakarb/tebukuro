class AddAddressToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :address, :string
  end
end
