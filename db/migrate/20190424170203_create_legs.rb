class CreateLegs < ActiveRecord::Migration[5.1]
  def change
    create_table :legs do |t|
      t.string :leg_type
      t.integer :selection
      t.integer :opponent
      t.boolean :won
      t.boolean :placed
      t.boolean :lost
      t.boolean :void
      t.integer :acca_id
    end
  end
end
