class Payement < ApplicationRecord
  belongs_to :order, class_name: "PayementOrder"
end
