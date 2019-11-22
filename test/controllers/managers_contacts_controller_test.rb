require 'test_helper'

class ManagersContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get managers_contacts_index_url
    assert_response :success
  end

  test "should get show" do
    get managers_contacts_show_url
    assert_response :success
  end

end
