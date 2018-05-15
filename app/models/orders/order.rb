class Order < ApplicationRecord
  self.per_page = 10
  # include ImageUploader::Attachment.new(:image)
  has_many :orderables, inverse_of: 'order'
  has_many :receipts, through: :orderables, inverse_of: 'orders'
  belongs_to :user
  belongs_to :group
  has_one :payement
  has_one :transfer_payement
  has_one :check_payement
  accepts_nested_attributes_for :payement, :allow_destroy => true
  attr_accessor :name

  validates :payement, presence: true
  validates_associated :payement

  before_validation :initiate, on: :create

  filterrific(
    default_filter_params: { sorted_by: 'created_at_asc' },
    available_filters: [
      :sorted_by,
      :by_month,
      :by_year,
      :with_group_id,
      :with_type,
      :with_payement_type
    ]
  )

  scope :selectized, ->(query, number) { where('(payements.name ILIKE ? OR number= ?) AND remain > 0', "%#{query}%", number) }
  scope :with_group_id, ->(id) {where(group_id: id)}
  scope :with_type, ->(type) {where(type: type)}
  scope :with_payement_type, ->(payement_type) { where('payements.type = ?', payement_type ) }
  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("orders.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      [I18n.t('tables.headers.timestamped')+ ' (asc)', 'created_at_asc'],
      [I18n.t('tables.headers.timestamped') + ' (desc)', 'created_at_desc']
    ]
  end

  def self.options_for_with_type
    [
      ['OP Marque', 'MdOrder'],
      ['OP Brevet', 'PdOrder']
    ]
  end

  def self.options_for_with_payement_type
    [
      ['Chèque', 'CheckPayement'],
      ['Versement', 'TransferPayement']
    ]
  end

  def self.options_for_by_month
    [
      ['Janvier', '1'],
      ['Fevrier', '2'],
      ['Mars', '3'],
      ['Avril', '4'],
      ['Mai', '5'],
      ['Juin', '6'],
      ['Juillet', '7'],
      ['Aout', '8'],
      ['Septembre', '9'],
      ['Octobre', '10'],
      ['Novembre', '11'],
      ['Decembre', '12']
    ]
  end

  def name
    return self.payement.name
  end

  private

  def initiate()
    self.number = set_number()
    self.remain = self.payement.value
  end

  def set_number
    number = Order.count()
    if number == 0 then
      return 1
    else
    number = Order.maximum(:number) + 1
    end
    return number
  end

end
require_dependency 'md_order'
require_dependency 'pd_order'
