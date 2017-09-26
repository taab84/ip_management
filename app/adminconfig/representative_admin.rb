RailsAdmin.config do |config|
  config.model 'Representative' do
    label "Mandataire"
    label_plural "Mandataires"
    weight 3
    edit do
      field :fullname
      field :adress
      field :wilaya
      field :email
      field :phone
      field :mobile
      field :fax
    end

    list do
      field :fullname
      field :adress
      field :wilaya
    end
  end
end
