class CreatePayementOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :payement_orders do |t|
      t.string :type
      t.integer :number
      t.decimal :remain, precision: 10, scale: 2, null: false, default: 0
      t.jsonb :image_data

      t.timestamps
    end
    add_index :payement_orders, :type, unique: false
    add_index :payement_orders, :number, unique: false
  end
end
