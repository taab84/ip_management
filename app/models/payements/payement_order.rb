class PayementOrder < ApplicationRecord
  # has_many :orderables, class_name: "Orderable"
end
require_dependency 'md_order'
require_dependency 'pd_order'
