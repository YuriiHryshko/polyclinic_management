require "test_helper"

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get recommendations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get recommendations_destroy_url
    assert_response :success
  end

  test "should get update" do
    get recommendations_update_url
    assert_response :success
  end
end
