class MdReceipt < Receipt
  has_many :orderables, class_name: "MdOrderable", inverse_of: 'receipt', :foreign_key => "receipt_id", dependent: :destroy
  has_many :orders, through: :orderables, class_name: "MdOrder", inverse_of: 'receipts'

  validates :number, uniqueness: { scope: :serie }
  def set_number
    number = MdReceipt.where(serie: Date.current.year).count() + 1
    return number
  end
end
require_dependency 'mark_receipt'
require_dependency 'similar_search_receipt'
