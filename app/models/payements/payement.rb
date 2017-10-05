class Payement < ApplicationRecord
  belongs_to :order, class_name: "PayementOrder", :foreign_key => "payement_order_id"
end
