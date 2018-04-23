class SimilarSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: [:integer, default: 1],
    number_classes: [:integer, default: 0],
    base_tax: :decimal,
    class_tax: :decimal

  validates_presence_of :number_searches, :number_classes

  def tax_calculate
    tax_line = Tax.where(code: "746-08", category: "base").first
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "746-08", category: "class").first
    self.class_tax = tax_line.current_tax
    self.total = (self.number_searches * self.base_tax) + (self.number_classes * self.class_tax)
  end
end
