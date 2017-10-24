class PayementOrder < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  # has_many :orderables, class_name: "Orderable", inverse_of: :order, dependent: :destroy
  # has_many :receipts, through: :orderables, class_name: "Receipt", inverse_of: :orders
  # has_one :payement, inverse_of: 'order'
  # has_one :check_payement, inverse_of: 'order'
  # has_one :transfer_payement, inverse_of: 'order'
  # accepts_nested_attributes_for :payement, :allow_destroy => true

end
require_dependency 'md_order'
require_dependency 'pd_order'
