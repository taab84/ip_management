class MarkReceipt < MdReceipt
  jsonb_accessor :data,
    mark_name: :string,
    mark_type: [:integer, default: 2],
    colored: [:boolean, default: true],
    classes: [:integer, default: 1],
    rev_pri: [:boolean, default: false],
    ipas_num: :integer


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
end
