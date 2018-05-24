class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :type, null: false
      t.integer :number, null: false
      t.decimal :remain, precision: 10, scale: 2, null: false, default: 0
      t.jsonb :image_data
      t.references :user, foreign_key: true, index: false, null: false
      t.references :group, foreign_key: true, index: false, null: false

      t.timestamps
    end
  end
end
