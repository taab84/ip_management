class Tax < ApplicationRecord
  validates :code, :description, :category, :current_tax, presence: true
  validates :current_tax, :next_tax, numericality: true
  validates :date_app, presence: true, if: :new_tax?
  validates :date_app, absence: true, unless: :new_tax?

  rails_admin do
    weight 4
    edit do
      field :code
      field :description
      field :category
      field :current_tax
      field :next_tax
      field :date_app
    end
    list do
      field :code
      field :description
      field :current_tax
    end
  end

  def self.updating
    @taxes = Tax.all
    Tax.transaction do
      @taxes.each do |tax|
        if (tax.next_tax != 0 && tax.date_app == Date.current)
          new_applied_tax = tax.next_tax
          tax.update(current_tax: new_applied_tax, next_tax: 0, date_app: "")
        end
      end
    end
  end

private

  def new_tax?
    next_tax != 0
  end

end
