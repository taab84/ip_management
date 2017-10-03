class MdOrder < PayementOrder
  has_many :orderables, class_name: "MdOrderable"
  has_many :receipts, through: :orderables, class_name: "MdReceipt"
end
