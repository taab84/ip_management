class AddEmailToRepresentative < ActiveRecord::Migration[5.1]
  def change
    add_column :representatives, :email, :string
  end
end
