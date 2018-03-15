class Payement < ApplicationRecord
  # belongs_to :order, class_name: "Order", :foreign_key => "order_id", inverse_of: :payement
  belongs_to :order
  # include ImageUploader::Attachment.new(:image)
end
# require_dependency 'transfer_payement'
# require_dependency 'check_payement'
