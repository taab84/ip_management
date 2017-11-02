class Receipt < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :representative, optional: true
  belongs_to :user
  # has_many :orderables, class_name: "Orderable", inverse_of: 'receipt', :foreign_key => "receipt_id", dependent: :destroy
  # has_many :orders, through: :orderables, class_name: "PayementOrder", inverse_of: 'receipts'

  before_validation :valuate, on: :create

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, presence: true

  private

  def valuate()
    self.serie = Date.current.year
    self.number = set_number()
  end
end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
