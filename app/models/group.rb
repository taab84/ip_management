class Group < ApplicationRecord
  has_many :users
  jsonb_accessor :contact,
    phone: :integer,
    mobile: :integer,
    fax: :integer
end
