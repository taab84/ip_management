RailsAdmin.config do |config|
  config.model 'User' do
    weight 1
    edit do
      field :username do
        label "Nom d'utilisateur"
      end
      field :type, :enum do
        enum_method do
          :type_enum
        end
      end
      field :group do
        label "Groupe"
      end
      field :email do
        label "e-Mail"
      end
    end
    list do
      field :username do
        label "Nom d'utilisateur"
      end
      field :type
      field :group do
        label "Groupe"
      end
      field :email do
        label "e-Mail"
      end
      field :created_at do
        label "Créé le"
      end
      field :current_sign_in_at do
        label "Derniére Connexion"
      end
    end
  end
end
