class SimilarSearchReceipt < MdReceipt
  jsonb_accessor :data,
    number_searches: :integer,
    number_classes: :integer
end
