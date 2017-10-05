class Group < ApplicationRecord
  rails_admin do
    weight 2
    list do
      field :name
      field :tenant
      field :adress
      field :email
      field :created_at
    end
    edit do
      field :name
      field :tenant
      field :adress
      field :email
      field :phone
      field :mobile
      field :fax
    end
  end
  has_many :users
  jsonb_accessor :contact,
    phone: :integer,
    mobile: :integer,
    fax: :integer
end
