class AddPurchasedToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :purchased, :boolean
  end
end
