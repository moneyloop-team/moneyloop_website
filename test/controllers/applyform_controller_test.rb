require 'test_helper'

class ApplyformControllerTest < ActionDispatch::IntegrationTest
  test "should get apply" do
    get applyform_apply_url
    assert_response :success
  end

end
