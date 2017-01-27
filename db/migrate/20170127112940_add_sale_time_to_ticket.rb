class AddSaleTimeToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :sale_starts_at, :datetime, :null => false
    add_column :tickets, :sale_ends_at, :datetime, :null => false
  end
end
