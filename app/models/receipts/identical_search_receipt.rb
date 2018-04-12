class IdenticalSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: :integer,
    number_classes: :integer,
    base_tax: [:decimal, default: 1],
    class_tax: [:decimal, default: 0]

  validates_presence_of :number_searches, :number_classes

  def tax_calculate
    tax_line = Tax.where(code: "746-07", category: "base").first
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "746-07", category: "class").first
    self.class_tax = tax_line.current_tax
    self.total = (self.number_searches * self.base_tax) + (self.number_classes * self.class_tax)
  end
end
