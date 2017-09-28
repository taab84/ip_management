RailsAdmin.config do |config|
  config.model 'Group' do
    weight 2
    list do
      field :name
      field :tenant
      field :adress
      field :email
      field :created_at
    end
    edit do
      field :name
      field :tenant
      field :adress
      field :email
      field :phone
      field :mobile
      field :fax
    end
  end
end
