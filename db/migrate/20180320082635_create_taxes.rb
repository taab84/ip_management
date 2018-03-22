class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
      t.string :code
      t.string :description
      t.string :category
      t.decimal :current_tax, precision: 10, scale: 2, null: false, default: 0
      t.decimal :next_tax, precision: 10, scale: 2, null: false, default: 0
      t.date :date_app

      t.timestamps
    end
  end
end
