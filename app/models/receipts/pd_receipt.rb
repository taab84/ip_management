class PdReceipt < Receipt
  has_many :orderables, class_name: "PdOrderable", inverse_of: 'receipt', :foreign_key => "receipt_id", dependent: :destroy
  has_many :orders, through: :orderables, class_name: "PdOrder", inverse_of: 'receipts'
  # accepts_nested_attributes_for :orderables
  # accepts_nested_attributes_for :orders, :allow_destroy => true

  validates :number, uniqueness: { scope: :serie }
  def set_number
    number = PdReceipt.where(serie: Date.current.year).count() + 1
    return number
  end
end
