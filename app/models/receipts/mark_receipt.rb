class MarkReceipt < MdReceipt
  jsonb_accessor :data,
    mark_name: :string,
    mark_type: [:string, default: :figuratif_and_verbal],
    colored: [:boolean, default: true],
    classes: [:integer, default: 1],
    rev_pri: [:boolean, default: false],
    ipas_num: :integer
  enum mark_type: [:figuratif, :verbal, :figuratif_and_verbal]
end
