require "test_helper"

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_categories_edit_url
    assert_response :success
  end
end
