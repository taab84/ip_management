class AddIndexToPayement < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, :remain
    add_index :orders, :created_at
    add_index :payements, :created_at
    add_index :receipts, :created_at
  end
end
