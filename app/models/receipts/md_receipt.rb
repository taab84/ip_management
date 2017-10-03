class MdReceipt < Receipt
  has_many :orderables, class_name: "MdOrderable"
  has_many :orders, through: :orderables, class_name: "MdOrder"
end
require_dependency 'mark_receipt'
require_dependency 'similar_search_receipt'
