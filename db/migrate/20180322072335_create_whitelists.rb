class CreateWhitelists < ActiveRecord::Migration[5.1]
  def change
    create_table :whitelists do |t|
      t.inet :ip_adress, null: false
      t.string :description

      t.timestamps
    end
  end
end
