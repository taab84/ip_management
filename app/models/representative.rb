class Representative < ApplicationRecord
  jsonb_accessor :contact,
    email: :string,
    phone: :integer,
    mobile: :integer,
    fax: :integer

  validates :fullname, :adress, :wilaya, :email, :phone, :mobile, presence: true
  validates :email, 'valid_email_2/email': true
  validates :phone, :mobile, :fax, numericality: true

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
  
end
