class Orderable < ApplicationRecord
  # belongs_to :payement_order, class_name: "Order"
  # belongs_to :receipt, class_name: "Receipt"
end
require_dependency 'md_orderable'
require_dependency 'pd_orderable'
