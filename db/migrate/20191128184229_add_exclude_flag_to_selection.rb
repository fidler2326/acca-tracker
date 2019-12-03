class AddExcludeFlagToSelection < ActiveRecord::Migration[5.1]
  def change
    add_column :selections, :hidden, :boolean, default: false
  end
end
