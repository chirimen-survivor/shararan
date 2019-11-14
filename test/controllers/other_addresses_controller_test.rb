require 'test_helper'

class OtherAddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get other_addresses_index_url
    assert_response :success
  end

  test "should get edit" do
    get other_addresses_edit_url
    assert_response :success
  end

end
