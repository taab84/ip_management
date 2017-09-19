RailsAdmin.config do |config|
  config.model 'Group' do
    base do
      field :name
      field :tenant
      field :adress
      field :email
    end
  end
end
