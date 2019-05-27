class CreateAccas < ActiveRecord::Migration[5.1]
  def change
    create_table :accas do |t|
      t.date :date
      t.string :category
      t.string :bet_type
      t.decimal :stake, precision: 20, scale: 8, default: nil
      t.decimal :return, precision: 20, scale: 8, default: nil
      t.integer :user_id
    end
  end
end
