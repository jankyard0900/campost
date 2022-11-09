require "test_helper"

class Public::CampReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_camp_reviews_new_url
    assert_response :success
  end
end
