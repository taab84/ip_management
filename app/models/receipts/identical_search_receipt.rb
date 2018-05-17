class IdenticalSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: [:integer, default: 1],
    number_additional_classes: [:integer, default: 0],
    base_tax: :decimal,
    class_tax: :decimal

  validates :number_searches, :number_additional_classes, presence: true
  validates :number_searches, :numericality => { :greater_than_or_equal_to => 1 }
  validates :number_additional_classes, :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :number_additional_classes,  less_than_or_equal_to: ->(identical_search_receipt) { identical_search_receipt.number_searches * 44 }

  def tax_calculate
    tax_line = Tax.where(code: "746-07", category: "base").first
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "746-07", category: "class").first
    self.class_tax = tax_line.current_tax
    self.total = (self.number_searches * self.base_tax) + 
      (self.number_additional_classes * self.class_tax)
  end
end
