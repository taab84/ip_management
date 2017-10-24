class Payement < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :order, class_name: "PayementOrder", :foreign_key => "payement_order_id", inverse_of: 'payement'
end
