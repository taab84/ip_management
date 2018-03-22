class MdReceipt < Receipt
  # has_many :orderables, class_name: "MdOrderable", inverse_of: 'receipt', dependent: :destroy
  # has_many :orders, through: :orderables, class_name: "MdOrder", inverse_of: 'receipts'

  validates :number, uniqueness: { scope: :serie }
  def set_number
    number = MdReceipt.where(serie: Date.current.year).count()
    if number == 0 then
      return 1
    else
      number = MdReceipt.where(serie: Date.current.year).maximum(:number) + 1
      return number
    end
  end
end
require_dependency 'mark_receipt'
require_dependency 'similar_search_receipt'
require_dependency 'identical_search_receipt'
