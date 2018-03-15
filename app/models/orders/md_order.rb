class MdOrder < Order
  # has_many :orderables, class_name: "MdOrderable", inverse_of: 'order', :foreign_key => "order_id"
  # has_many :receipts, through: :orderables, class_name: "MdReceipt", inverse_of: 'orders'
end
