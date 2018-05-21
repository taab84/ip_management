module ApplicationHelper
  def flash_class_name(name)
    case name
    when "notice" then "success"
    when "alert"  then "warning"
    else name
    end
  end
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
