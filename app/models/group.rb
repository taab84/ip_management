class Group < ApplicationRecord
  has_many :users
  jsonb_accessor :contact,
    phone: :integer,
    mobile: :integer,
    fax: :integer
  
  validates :name, :tenant, :adress, :email, presence: true
  validates :email, 'valid_email_2/email': true
  validates :phone, :mobile, :fax, numericality: true, :allow_nil => true
  
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
end
