class PdOrder < PayementOrder
  has_many :orderables, class_name: "PdOrderable", inverse_of: 'order', :foreign_key => "payement_order_id"
  has_many :receipts, through: :orderables, class_name: "PdReceipt", inverse_of: 'orders'
end
