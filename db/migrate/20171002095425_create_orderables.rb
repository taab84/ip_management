class CreateOrderables < ActiveRecord::Migration[5.1]
  def change
    create_table :orderables do |t|
      t.string :type
      t.references :payement_order, foreign_key: true
      t.references :receipt, foreign_key: true

      t.timestamps
    end
    add_index :orderables, :type, unique: false
  end
end