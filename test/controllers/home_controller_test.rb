require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get info" do
    get home_info_url
    assert_response :success
  end

  test "should get help" do
    get home_help_url
    assert_response :success
  end

end
