class Receipt < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :representative, optional: true
  belongs_to :user
  has_many :orderables, inverse_of: 'receipt', dependent: :destroy
  has_many :orders, through: :orderables, inverse_of: 'receipts'

  # validates_associated :orderables
  
  before_validation :valuate, on: :create
  # after_validation :setting_op, on: :create

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, :type, presence: true

  def setting_op
    self.transaction do
      value_comp = self.total
      id = self.id
      self.orders.each do |order|
        if (value_comp > 0) && (order.remain > 0)
          if order.remain >= value_comp
            @orderable = order.orderables.new(used: value_comp, receipt_id: id, order_id: order.id)
            @orderable.save
            order.remain = order.remain - value_comp
            value_comp = 0
            order.save
          elsif order.remain < value_comp
            value_comp = value_comp - order.remain
            @orderable = order.orderables.new(used: order.remain, receipt_id: id, order_id: order.id)
            @orderable.save
            order.remain = 0
            order.save
          end
        end
      end
    end
  end

  def paid_sum
    self.orders.sum(:remain)
  end

  private

  def valuate()
    self.serie = Date.current.year
    self.number = set_number()
    self.tax_calculate()
    if (self.total < self.orders.sum(:remain))
      self.errors.add(:total, :not_enough)
    end
  end

end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
