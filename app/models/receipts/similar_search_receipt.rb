class SimilarSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: :integer,
    number_classes: :integer,
    base_tax: :decimal,
    class_tax: :decimal

  validates_presence_of :number_searches, :number_classes

  def tax_calculate
    
  end
end
