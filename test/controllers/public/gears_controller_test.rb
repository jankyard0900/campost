require "test_helper"

class Public::GearsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_gears_new_url
    assert_response :success
  end

  test "should get index" do
    get public_gears_index_url
    assert_response :success
  end

  test "should get show" do
    get public_gears_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_gears_edit_url
    assert_response :success
  end

  test "should get search" do
    get public_gears_search_url
    assert_response :success
  end
end
