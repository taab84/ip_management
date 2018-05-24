class CreateOrderables < ActiveRecord::Migration[5.1]
  def change
    create_table :orderables do |t|
      t.string :type
      t.decimal :used, precision: 10, scale: 2, default: 0
      t.references :order, foreign_key: true, index: false, null: false
      t.references :receipt, foreign_key: true, index: false, null: false

      t.timestamps
    end
  end
end
