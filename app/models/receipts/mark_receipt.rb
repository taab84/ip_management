class MarkReceipt < MdReceipt
  jsonb_accessor :data,
    mark_name: :string,
    mark_type: [:integer, default: 2],
    colored: [:boolean, default: true],
    classes: [:integer, default: 1],
    rev_pri: [:boolean, default: false],
    ipas_num: :integer,
    base_tax: :decimal,
    class_tax: :decimal,
    rev_tax: :decimal

  enum mark_type: [ :figuratif, :verbal, :figuratif_and_verbal ]


  validates :mark_name, presence: true, unless: :pictured?
  validates :mark_name, absence: true, if: :pictured?
  validates :colored, exclusion: { in: [true]}, if: :verbalized?
  validates :classes, inclusion: { in: 1..45 }

  def verbalized?
    mark_type == 'verbal'
  end

  def pictured?
    mark_type == 'figuratif'
  end

  def tax_calculate
    if self.colored? then
      self.base_tax = 15000
    else
      self.base_tax = 14000
    end
    self.class_tax = 2000

    if self.rev_pri? then
      self.rev_tax = 1000
    else
      self.rev_tax = 0
    end
    self.total = self.base_tax + (self.class_tax * self.classes) + self.rev_tax
  end
end
