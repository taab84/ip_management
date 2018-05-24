class AddIndexToPayement < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!
  def change
    add_index :groups, :name, unique: true, algorithm: :concurrently
    add_index :groups, :tenant, unique: true, algorithm: :concurrently
    add_index :users, :email, unique: true, algorithm: :concurrently
    add_index :users, :username, unique: true, algorithm: :concurrently
    add_index :users, :type, unique: false, algorithm: :concurrently
    add_index :users, :group_id, unique: false, algorithm: :concurrently
    add_index :representatives, :fullname, unique: true, algorithm: :concurrently
    add_index :representatives, :contact, using: :gin, unique: false, algorithm: :concurrently
    add_index :receipts, :type, unique: false, algorithm: :concurrently
    add_index :receipts, [:number, :serie, :branch], unique: true, algorithm: :concurrently
    add_index :receipts, :owner_name, unique: false, algorithm: :concurrently
    add_index :receipts, :owner_adress, unique: false, using: :gin, algorithm: :concurrently
    add_index :receipts, :data, unique: false, using: :gin, algorithm: :concurrently
    add_index :receipts, :created_at, unique: true, algorithm: :concurrently
    add_index :receipts, :user_id, unique: false, algorithm: :concurrently
    add_index :receipts, :group_id, unique: false, algorithm: :concurrently
    add_index :receipts, :representative_id, unique: false, algorithm: :concurrently
    add_index :orders, :type, unique: false, algorithm: :concurrently
    add_index :orders, :number, unique: false, algorithm: :concurrently
    add_index :orders, :remain, algorithm: :concurrently
    add_index :orders, :created_at, unique: true, algorithm: :concurrently
    add_index :orders, :user_id, unique: false, algorithm: :concurrently
    add_index :orders, :group_id, unique: false, algorithm: :concurrently
    add_index :orderables, :type, unique: false, algorithm: :concurrently
    add_index :orderables, [:receipt_id, :order_id], unique: true, algorithm: :concurrently
    add_index :payements, :created_at, unique: true, algorithm: :concurrently
    add_index :payements, :order_id, unique: true, algorithm: :concurrently
    add_index :payements, :type, unique: false, algorithm: :concurrently
    add_index :payements, :name, unique: false, algorithm: :concurrently
    add_index :payements, :date, unique: false, algorithm: :concurrently
    add_index :payements, :data, unique: false, using: :gin, algorithm: :concurrently
  end
end
