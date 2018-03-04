class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.string :name, null: false
      t.references :event, foreign_key: true, index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
