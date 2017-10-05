class CheckPayement < Payement
  jsonb_accessor :data,
    number: :integer,
    state: :integer
  validates :number, length: {is: 7}, allow_blank: false
end
