RailsAdmin.config do |config|

  # inherit from main app controller
  config.parent_controller = 'ApplicationController'

  # Models to exclude from dashboard
  config.included_models = ["Group", "User", "Representative", "Tax", "Whitelist"]
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  # == IP address resctiction
  # config.authorize_with do
  #   if Whitelist.find_by(ip_adress: request.remote_ip).nil?
  #     redirect_to main_app.root_path, :alert => I18n.t('unauthorized_ip'), :class => "alert"
  #   end
  # end

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
