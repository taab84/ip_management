class MarkReceipt < MdReceipt
  jsonb_accessor :data,
    mark_name: :string,
    mark_type: [:integer, default: 2],
    colored: [:boolean, default: true],
    classes: [:integer, default: 1],
    rev_pri: [:boolean, default: false],
    international: [:boolean, default: false],
    ipas_num: :integer,
    base_tax: :decimal,
    class_tax: :decimal,
    rev_tax: :decimal,
    int_tax: :decimal

  enum mark_type: [:figuratif, :verbal, :figuratif_and_verbal]


  validates :mark_name, presence: true, unless: :pictured?
  validates :mark_name, absence: true, if: :pictured?
  validates :colored, exclusion: { in: [true] }, if: :verbalized?
  validates :classes, inclusion: { in: 1..45 }

  def verbalized?
    mark_type == 'verbal'
  end

  def pictured?
    mark_type == 'figuratif'
  end

  def tax_calculate
    if self.colored? then
      tax_line = Tax.where(code: "746-01", category: "colored").first
    else
      tax_line = Tax.where(code: "746-01", category: "uncolored").first
    end
    self.base_tax = tax_line.current_tax
    tax_line = Tax.where(code: "746-02").first
    self.class_tax = tax_line.current_tax
    if self.rev_pri? then
      tax_line = Tax.where(code: "746-03").first
      self.rev_tax = tax_line.current_tax
    else
      self.rev_tax = 0
    end
    if self.international? then
      tax_line = Tax.where(code: "746-15").first
      self.int_tax = tax_line.current_tax
    else
      self.int_tax = 0
    end
    self.total = self.base_tax + (self.class_tax * self.classes) + self.rev_tax + self.int_tax
  end
end
