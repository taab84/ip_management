class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :tenant, null: false
      t.string :adress
      t.string :email
      t.jsonb :contact

      t.timestamps
    end
  end
end
