class CreateTicketSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_subscriptions do |t|
      t.references :ticket, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
