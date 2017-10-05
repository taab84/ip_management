class PdReceipt < Receipt
  has_many :orderables, class_name: "PdOrderable", inverse_of: 'receipt', :foreign_key => "receipt_id"
  has_many :orders, through: :orderables, class_name: "PdOrder", inverse_of: 'receipts'
end
