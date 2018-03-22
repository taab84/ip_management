class CreateWhitelists < ActiveRecord::Migration[5.1]
  def change
    create_table :whitelists do |t|
      t.inet :ip_adress
      t.string :description

      t.timestamps
    end
    add_index :whitelists, :ip_adress
  end
end
