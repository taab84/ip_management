class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :verify_ip_address
  self.page_cache_directory = -> { Rails.root.join("public", request.domain) }

  protected

  def configure_permitted_parameters
    expire_fragment("navbar_cache")
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :fullname]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:educator_locale] = l
    end
    I18n.locale = l
  end

  def verify_ip_address
    if Whitelist.find_by(ip_adress: request.remote_ip).nil?
      redirect_to main_app.root_path, alert: I18n.t('unauthorized_ip')
    end
  end

end
