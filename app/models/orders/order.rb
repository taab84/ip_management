class Order < ApplicationRecord
  # include ImageUploader::Attachment.new(:image)
  has_many :orderables, inverse_of: 'order'
  has_many :receipts, through: :orderables, inverse_of: 'orders'
  has_one :payement
  has_one :transfer_payement
  has_one :check_payement
  accepts_nested_attributes_for :payement, :allow_destroy => true

  validates :payement, presence: true
  validates_associated :payement

  before_validation :initiate, on: :create

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
