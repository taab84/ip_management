class CreateRepresentatives < ActiveRecord::Migration[5.1]
  def change
    create_table :representatives do |t|
      t.string :fullname
      t.string :adress
      t.string :wilaya
      t.jsonb :contact

      t.timestamps
    end
    add_index :representatives, :fullname,                unique: true
    add_index :representatives, :contact, using: :gin,    unique: false
  end
end
