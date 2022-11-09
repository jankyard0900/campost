require "test_helper"

class Public::GearReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_gear_reviews_new_url
    assert_response :success
  end
end
