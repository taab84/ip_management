class CreateRepresentatives < ActiveRecord::Migration[5.1]
  def change
    create_table :representatives do |t|
      t.string :fullname, null: false
      t.string :adress, null: false
      t.string :wilaya
      t.jsonb :contact

      t.timestamps
    end
  end
end
