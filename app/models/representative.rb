class Representative < ApplicationRecord
  jsonb_accessor :contact,
    phone: :integer,
    mobile: :integer,
    fax: :integer
end
