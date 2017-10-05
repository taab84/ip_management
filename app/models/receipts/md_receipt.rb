class MdReceipt < Receipt
  has_many :orderables, class_name: "MdOrderable", inverse_of: 'receipt', :foreign_key => "receipt_id"
  has_many :orders, through: :orderables, class_name: "MdOrder", inverse_of: 'receipts'
end
require_dependency 'mark_receipt'
require_dependency 'similar_search_receipt'
