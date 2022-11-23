require "test_helper"

class CustomerOrderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_order_show_url
    assert_response :success
  end
end
