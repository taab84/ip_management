module ApplicationHelper
  def flash_class_name(name)
    case name
    when "notice" then "success"
    when "alert"  then "warning"
    else name
    end
  end
end
