class PdOrder < PayementOrder
  has_many :orderables, class_name: "PdOrderable"
  has_many :receipts, through: :pd_orderables, class_name: "PdReceipt"
end
