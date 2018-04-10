class Tax < ApplicationRecord
    validates :code, :description, :category, :current_tax, presence: true
    validates :current_tax, :next_tax, numericality: true

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
end
