class Whitelist < ApplicationRecord
    validates :ip_adress, :description, presence: true

    rails_admin do
        weight 5
        edit do
          field :ip_adress
          field :description
        end
        list do
          field :ip_adress
          field :description
        end
    end
end
