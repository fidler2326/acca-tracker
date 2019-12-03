class AddEventAndOddsToLeg < ActiveRecord::Migration[5.1]
  def change
    add_column :legs, :event, :string
    add_column :legs, :odds, :string
  end
end
