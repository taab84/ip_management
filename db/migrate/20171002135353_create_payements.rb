class CreatePayements < ActiveRecord::Migration[5.1]
  def change
    create_table :payements do |t|
      t.string :type, null: false
      t.decimal :value, precision: 10, scale: 2, null: false, default: 0
      t.string :name, null: false
      t.date :date, null: false
      t.jsonb :data, null: false
      t.jsonb :image_data
      t.references :order, foreign_key: true, index: false, null: false

      t.timestamps
    end
  end
end
