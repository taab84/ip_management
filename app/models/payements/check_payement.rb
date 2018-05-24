class CheckPayement < Payement
  jsonb_accessor :data,
    bank: :string,
    number: :integer,
    state: [:integer, default: 0]
    
  validates :number, length: {less_than_or_equal_to: 7}, allow_blank: false
end
