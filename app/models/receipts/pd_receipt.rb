class PdReceipt < Receipt
  # has_many :orderables, class_name: "PdOrderable", inverse_of: 'receipt', :foreign_key => "receipt_id", dependent: :destroy
  # has_many :orders, through: :orderables, class_name: "PdOrder", inverse_of: 'receipts'

  def set_number
    number = PdReceipt.where(serie: Date.current.year).count()
    if number == 0 then
      return 1
    else
      number = PdReceipt.where(serie: Date.current.year).maximum(:number) + 1
      return number
    end
  end

  def branching
    return 1
  end
end
