require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contact_index_url
    assert_response :success
  end

  test "should get send_email" do
    get contact_send_email_url
    assert_response :success
  end

end
