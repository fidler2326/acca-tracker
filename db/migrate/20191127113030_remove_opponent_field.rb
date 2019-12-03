class RemoveOpponentField < ActiveRecord::Migration[5.1]
  def change
    remove_column :legs, :opponent
  end
end
