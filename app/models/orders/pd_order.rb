class PdOrder < Order
  # has_many :orderables, class_name: "PdOrderable", inverse_of: 'order', :foreign_key => "order_id"
  # has_many :receipts, through: :orderables, class_name: "PdReceipt", inverse_of: 'orders'
end
