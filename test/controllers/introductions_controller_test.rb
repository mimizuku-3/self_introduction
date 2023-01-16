require 'test_helper'

class IntroductionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get introductions_index_url
    assert_response :success
  end

end
