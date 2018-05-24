class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.string :type
      t.integer :status, null: false, default: 0
      t.integer :serie, null: false
      t.integer :number, null: false
      t.integer :branch, null: false
      t.string :owner_name, null: false
      t.jsonb :owner_adress, null: false
      t.decimal :total, precision: 10, scale:2, null: false, default: 0
      t.jsonb :data, null: false
      t.jsonb :image_data
      t.references :representative, foreign_key: true, index: false
      t.references :user, foreign_key: true, index: false, null: false
      t.references :group, foreign_key: true, index: false, null: false

      t.timestamps
    end
    
  end
end
