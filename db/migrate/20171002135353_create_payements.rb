class CreatePayements < ActiveRecord::Migration[5.1]
  def change
    create_table :payements do |t|
      t.string :type
      t.decimal :value, precision: 10, scale: 2, null: false, default: 0
      t.string :name
      t.date :date
      t.jsonb :data
      t.jsonb :image_data
      t.references :payement_order, foreign_key: true

      t.timestamps
    end
    add_index :payements, :type, unique: false
    add_index :payements, :name, unique: false
    add_index :payements, :date, unique: false
    add_index :payements, :data, unique: false, using: :gin
  end
end
