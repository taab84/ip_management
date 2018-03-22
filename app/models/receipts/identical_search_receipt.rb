class IdenticalSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: :integer,
    number_classes: :integer,
    base_tax: :decimal,
    class_tax: :decimal

  def tax_calculate
  end
end
