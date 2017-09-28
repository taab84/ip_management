class Receipt < ApplicationRecord
  belongs_to :representative, optional: true
  belongs_to :user
end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
