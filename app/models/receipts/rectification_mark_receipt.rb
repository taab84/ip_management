class RectificationMarkReceipt < MdReceipt
  jsonb_accessor :data,
    number_marks: [:integer, default: 1],
    tax: :decimal

  validates :number_marks, numericality: {integer: true}

  def tax_calculate
    self.tax = Tax.where(code: "746-09", category: "error").first.current_tax
    self.total = self.tax * self.number_marks
  end
end