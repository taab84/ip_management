class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :type
      t.integer :number
      t.decimal :remain, precision: 10, scale: 2, null: false, default: 0
      t.jsonb :image_data

      t.timestamps
    end
    add_index :orders, :type, unique: false
    add_index :orders, :number, unique: false
  end
end
