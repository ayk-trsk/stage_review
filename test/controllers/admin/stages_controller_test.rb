require 'test_helper'

class Admin::StagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_stages_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_stages_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_stages_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_stages_edit_url
    assert_response :success
  end

end
