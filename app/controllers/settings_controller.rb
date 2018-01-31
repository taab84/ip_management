class SettingsController < ApplicationController
  def change_locale
    expire_fragment("navbar_cache")
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:educator_locale] = l
    redirect_to request.referer || root_url
  end
end
