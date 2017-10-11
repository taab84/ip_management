class Receipt < ApplicationRecord
  belongs_to :representative, optional: true
  belongs_to :user
  # has_many :orderables, class_name: "Orderable"

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, presence: true
end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
