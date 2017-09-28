class Representative < ApplicationRecord
  jsonb_accessor :contact,
    email: :string,
    phone: :integer,
    mobile: :integer,
    fax: :integer
end
