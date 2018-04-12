class MarkReceipt < MdReceipt
  jsonb_accessor :data,
    mark_name: :string,
    mark_type: [:integer, default: 2],
    colored: [:boolean, default: true],
    classes: [:integer, default: 1],
    rev_pri: [:boolean, default: false],
    ipas_num: :integer,
    base_tax: :decimal,
    base_description: :string,
    class_tax: :decimal,
    class_description: :string,
    rev_tax: :decimal,
    rev_description: :string

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
    self.base_description = tax_line.description
    tax_line = Tax.where(code: "746-02").first
    self.class_tax = tax_line.current_tax
    self.class_description =  tax_line.description
    if self.rev_pri? then
      tax_line = Tax.where(code: "746-03").first
      self.rev_tax = tax_line.current_tax
      self.rev_description = tax_line.description
    else
      self.rev_tax = 0
    end
    self.total = self.base_tax + (self.class_tax * self.classes) + self.rev_tax
  end
end
