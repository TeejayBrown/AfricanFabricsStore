require "test_helper"

class OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get order_show_url
    assert_response :success
  end
end
