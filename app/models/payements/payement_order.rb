class PayementOrder < ApplicationRecord
  has_many :orderables, class_name: "Orderable"
  has_one :payement
  has_one :check_payement
  has_one :transfer_payement
end
require_dependency 'md_order'
require_dependency 'pd_order'
