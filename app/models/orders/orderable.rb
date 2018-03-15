class Orderable < ApplicationRecord
    belongs_to :order
    belongs_to :receipt
end
require_dependency 'md_orderable'
require_dependency 'pd_orderable'
