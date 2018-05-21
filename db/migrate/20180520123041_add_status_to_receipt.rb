class AddStatusToReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :status, :integer, default: 0
  end
end
