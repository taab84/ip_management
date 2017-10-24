class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.string :type
      t.integer :serie
      t.integer :number
      t.string :owner_name
      t.jsonb :owner_adress
      t.decimal :total, precision: 10, scale:2, null: false, default: 0
      t.jsonb :data
      t.jsonb :image_data
      t.references :representative, foreign_key: true, index: true
      t.references :user,   foreign_key: true, index: true

      t.timestamps
    end
    add_index :receipts, :type, unique: false
    add_index :receipts, :serie, unique: false
    add_index :receipts, :number, unique: false
    add_index :receipts, :owner_name, unique: false
    add_index :receipts, :owner_adress, unique: false, using: :gin
    add_index :receipts, :data, unique: false, using: :gin
  end
end
