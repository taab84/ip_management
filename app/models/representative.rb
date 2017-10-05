class Representative < ApplicationRecord
  rails_admin do
    weight 3
    edit do
      field :fullname
      field :adress
      field :wilaya
      field :email
      field :phone
      field :mobile
      field :fax
    end

    list do
      field :fullname
      field :adress
      field :wilaya
    end
  end
  jsonb_accessor :contact,
    email: :string,
    phone: :integer,
    mobile: :integer,
    fax: :integer
end
