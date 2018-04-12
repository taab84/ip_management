class Receipt < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :representative, optional: true
  belongs_to :user
  has_many :orderables, inverse_of: 'receipt', dependent: :destroy
  has_many :orders, through: :orderables, inverse_of: 'receipts'

  validates_presence_of :orders
  validate :sum_remain_must_be_enough

  before_validation :valuate, on: :create

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, :type, presence: true

  def setting_op
    transaction do
      save
      value_comp = total
      id = self.id
      orders.each do |order|
        if value_comp.positive? && order.remain.positive?
          if order.remain >= value_comp
            @orderable = order.orderables.create(
              used: value_comp, receipt_id: id, order_id: order.id
            )
            order.remain = order.remain - value_comp
            value_comp = 0
            order.save
          elsif order.remain < value_comp
            value_comp -= order.remain
            @orderable = order.orderables.create(
              used: order.remain, receipt_id: id, order_id: order.id
            )
            order.remain = 0
            order.save
          end
        end
      end
    end
  end

  def paid_sum
    total = 0
    orders.each do |order|
      total += order.remain
    end
    total
  end

  private

  def sum_remain_must_be_enough
    errors.add(:orders, :not_enough) if total > paid_sum
  end

  def valuate
    self.serie = Date.current.year
    self.number = set_number
    tax_calculate
  end

end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
