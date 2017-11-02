class Payement < ApplicationRecord
  # belongs_to :order, class_name: "PayementOrder", :foreign_key => "payement_order_id", inverse_of: :payement
  belongs_to :payement_order
  # include ImageUploader::Attachment.new(:image)
end
# require_dependency 'transfer_payement'
# require_dependency 'check_payement'
