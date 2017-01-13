class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
