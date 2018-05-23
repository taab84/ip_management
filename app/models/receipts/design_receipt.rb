class DesignReceipt < MdReceipt
  jsonb_accessor :data,
    models: [:integer, default: 1],
    draws: [:integer, default: 0],
    pics: [:integer, default: 1],
    base_tax: :decimal,
    models_tax: :decimal,
    holding_tax: :decimal,
    draws_tax: :decimal,
    pics_tax: :decimal

  validates :models, :numericality => { :greater_than_or_equal_to => 1 }
  validates :draws, :pics, :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :models, less_than_or_equal_to: ->(design_receipt) { design_receipt.draws + design_receipt.pics }

  def tax_calculate
    tax_line = Tax.where(code: "747-00", category: "base").first
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "747-01", category: "model").first
    self.models_tax = tax_line.current_tax
    tax_line = Tax.where(code: "747-04", category: "holding").first
    self.holding_tax = tax_line.current_tax
    tax_line = Tax.where(code: "747-03", category: "draws").first
    self.draws_tax = tax_line.current_tax
    tax_line = Tax.where(code: "747-03", category: "pictures").first
    self.pics_tax = tax_line.current_tax
    self.total = self.base_tax + ((self.models_tax + self.holding_tax) * self.models) + (self.draws_tax * self.draws) + (self.pics_tax * self.pics)
  end
end
