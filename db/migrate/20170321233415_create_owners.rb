class CreateOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :owners do |t|
      t.references :community, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
