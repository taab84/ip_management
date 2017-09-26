class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.string :type
      t.integer :serie
      t.integer :number
      t.string :name
      t.string :adress
      t.decimal :total
      t.jsonb :image_data
      t.references :representative, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :receipts, :type,   unique: false
    add_index :receipts, :serie,  unique: false
    add_index :receipts, :number, unique: false
    add_index :receipts, :name,   unique: false
  end
end
