class CheckPayement < Payement
  jsonb_accessor :data,
    number: :integer,
    state: :integer
  validates :number, length: {less_than_or_equal_to: 7}, allow_blank: false
end
