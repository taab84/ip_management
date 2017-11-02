class PayementOrder < ApplicationRecord
  # include ImageUploader::Attachment.new(:image)
  has_one :payement
  has_one :transfer_payement
  has_one :check_payement
  accepts_nested_attributes_for :payement, :allow_destroy => true
  # accepts_nested_attributes_for :transfer_payement, :allow_destroy => true
  # accepts_nested_attributes_for :check_payement, :allow_destroy => true


  before_validation :initiate, on: :create

  private

  def initiate()
    self.number = set_number()
  end

  def set_number
    number = PayementOrder.count() + 1
    return number
  end

end
require_dependency 'md_order'
require_dependency 'pd_order'
