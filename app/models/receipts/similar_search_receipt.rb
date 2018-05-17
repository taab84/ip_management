class SimilarSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: [:integer, default: 1],
    number_searches_with_more_than_three_classes: [:integer, default: 0],
    base_tax: :decimal,
    class_tax: :decimal

  validates_presence_of :number_searches, :number_searches_with_more_than_three_classes
  validates :number_searches, :numericality => { :greater_than_or_equal_to => 1 }
  validates :number_searches_with_more_than_three_classes, 
    :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :number_searches_with_more_than_three_classes, 
    less_than_or_equal_to: ->(similar_search_receipt) { similar_search_receipt.number_searches }

  def tax_calculate
    tax_line = Tax.where(code: "746-08", category: "base").first
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "746-08", category: "class").first
    self.class_tax = tax_line.current_tax
    self.total = (self.number_searches * self.base_tax) + 
      (self.number_searches_with_more_than_three_classes * self.class_tax)
  end
end
