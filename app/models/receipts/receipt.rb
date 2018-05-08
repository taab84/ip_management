class Receipt < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :representative, optional: true
  belongs_to :user
  belongs_to :group
  has_many :orderables, inverse_of: 'receipt', dependent: :destroy
  has_many :orders, through: :orderables, inverse_of: 'receipts'
  has_many :payements, through: :orders

  validates :order_ids, presence: true
  validate :sum_remain_must_be_enough

  before_validation :valuate, on: :create

  jsonb_accessor :owner_adress,
    owner_street: :string,
    owner_wilaya: :string

  validates :owner_name, :owner_street, :owner_wilaya, :type, presence: true

  enum owner_wilaya: { "Adrar" => "Adrar",
    "Chlef"           => "Chlef",
    "Laghouat"   => "Laghouat",
    "Oum El Bouaghi"     => "Oum El Bouaghi",
    "Batna" => "Batna",
    "Béjaïa" => "Béjaïa",
    "Biskra" => "Biskra",
    "Béchar" => "Béchar",
    "Blida" => "Blida",
    "Bouira" => "Bouira",
    "Tamanrasset" => "Tamanrasset",
    "Tébessa" => "Tébessa",
    "Tlemcen" => "Tlemcen",
    "Tiaret" => "Tiaret",
    "Tizi Ouzou" => "Tizi Ouzou",
    "Alger" => "Alger",
    "Djelfa" => "Djelfa",
    "Jijel" => "Jijel",
    "Sétif" => "Sétif",
    "Saïda" => "Saïda",
    "Skikda" => "Skikda",
    "Sidi Bel Abbès" => "Sidi Bel Abbès",
    "Annaba" => "Annaba",
    "Guelma" => "Guelma",
    "Constantine" => "Constantine",
    "Médéa" => "Médéa",
    "Mostaganem" => "Mostaganem",
    "M'Sila" => "M'Sila",
    "Mascara" => "Mascara",
    "Ouargla" => "Ouargla",
    "Oran" => "Oran",
    "El Bayadh" => "El Bayadh",
    "Illizi" => "Illizi",
    "Bordj Bou Arreridj" => "Bordj Bou Arreridj",
    "Boumerdès" => "Boumerdès",
    "El Tarf" => "El Tarf",
    "Tindouf" => "Tindouf",
    "Tissemsilt" => "Tissemsilt",
    "El Oued" => "El Oued",
    "Khenchela" => "Khenchela",
    "Souk Ahras" => "Souk Ahras",
    "Tipaza" => "Tipaza",
    "Mila" => "Mila",
    "Aïn Defla" => "Aïn Defla",
    "Naâma" => "Naâma",
    "Aïn Témouchent" => "Aïn Témouchent",
    "Ghardaïa" => "Ghardaïa",
    "Relizane" => "Relizane"
    }

  def setting_op
    transaction do
      save
      value_comp = total
      id = self.id
      orders.each do |order|
        if value_comp.positive? && order.remain.positive?
          if order.remain >= value_comp
            @orderable = order.orderables.where(receipt_id: id, order_id: order.id).update(
              used: value_comp
              )
            order.remain = order.remain - value_comp
            value_comp = 0
            order.save
          elsif order.remain < value_comp
            value_comp -= order.remain
            @orderable = order.orderables.where(receipt_id: id, order_id: order.id).update(
              used: order.remain
              )
            order.remain = 0
            order.save
          end
        end
      end
    end
  end

  def paid_sum
    total = 0
    orders.each do |order|
      total += order.remain
    end
    total
  end

  private

  def sum_remain_must_be_enough
    errors.add(:order_ids, :not_enough) if total > paid_sum
  end

  def valuate
    self.serie = Date.current.year
    self.number = set_number
    Tax.updating
    tax_calculate
  end

end
require_dependency 'md_receipt'
require_dependency 'pd_receipt'
