class MdOrder < PayementOrder
  has_many :orderables, class_name: "MdOrderable", inverse_of: 'order', :foreign_key => "payement_order_id"
  has_many :receipts, through: :orderables, class_name: "MdReceipt", inverse_of: 'orders'
end
