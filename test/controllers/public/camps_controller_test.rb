require "test_helper"

class Public::CampsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_camps_new_url
    assert_response :success
  end

  test "should get index" do
    get public_camps_index_url
    assert_response :success
  end

  test "should get show" do
    get public_camps_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_camps_edit_url
    assert_response :success
  end

  test "should get search" do
    get public_camps_search_url
    assert_response :success
  end
end
