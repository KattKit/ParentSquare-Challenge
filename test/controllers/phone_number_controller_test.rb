require "test_helper"

class PhoneNumberControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get phone_number_index_url
    assert_response :success
  end

  test "should get show" do
    get phone_number_show_url
    assert_response :success
  end
end
