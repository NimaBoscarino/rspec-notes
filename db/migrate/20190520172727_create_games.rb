class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :price
      t.string :name
      t.string :developer

      t.timestamps
    end
  end
end
