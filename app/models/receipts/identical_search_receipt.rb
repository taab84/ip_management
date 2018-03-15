class IdenticalSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: :integer,
    number_classes: :integer

  def tax_calculate
  end
end
