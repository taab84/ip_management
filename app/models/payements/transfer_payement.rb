class TransferPayement < Payement
  jsonb_accessor :data,
    serie: :integer,
    number: :integer,
    ref: :integer
end
