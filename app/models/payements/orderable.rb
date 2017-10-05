class Orderable < ApplicationRecord
  belongs_to :payement_order, class_name: "PayementOrder", :foreign_key => "payement_order_id"
  belongs_to :receipt, class_name: "Receipt", :foreign_key => "receipt_id"
end
require_dependency 'md_orderable'
require_dependency 'pd_orderable'
