class AddUsedToOrderable < ActiveRecord::Migration[5.1]
  def change
    add_column :orderables, :used, :decimal, precision: 10, scale: 2, default: 0
  end
end
