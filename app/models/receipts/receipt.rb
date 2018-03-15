class Receipt < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :representative, optional: true
  belongs_to :user
  has_many :orderables, inverse_of: 'receipt', dependent: :destroy
  has_many :orders, through: :orderables, inverse_of: 'receipts'

  before_validation :valuate, on: :create

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, :type, presence: true

  private

  def valuate()
    self.serie = Date.current.year
    self.number = set_number()
    self.tax_calculate()
  end
end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
