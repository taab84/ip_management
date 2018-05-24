class TransferPayement < Payement
  jsonb_accessor :data,
    bank: :string,
    serie: :integer,
    number: :integer,
    ref: :integer

  before_validation :valuate, on: :create

  private

  def set_number
    number = TransferPayement.data_where(serie: Date.current.year).count()
    if number == 0 then
      return 1
    else
      last = TransferPayement.jsonb_order(:data, :number, :desc).data_where(serie: Date.current.year).first
      number = last.number + 1
      return number
    end
  end

  def valuate
    self.serie = Date.current.year
    self.number = set_number
  end
end
