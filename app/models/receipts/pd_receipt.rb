class PdReceipt < Receipt
  has_many :orderables, class_name: "PdOrderable"
  has_many :orders, through: :orderables, class_name: "PdOrder"
end
