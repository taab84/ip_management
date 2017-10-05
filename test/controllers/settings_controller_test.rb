require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get change_locale" do
    get settings_change_locale_url
    assert_response :success
  end

end
