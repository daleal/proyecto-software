require 'test_helper'

class ModeratorRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get moderator_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get moderator_requests_create_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_requests_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_requests_update_url
    assert_response :success
  end

  test "should get show" do
    get moderator_requests_show_url
    assert_response :success
  end

  test "should get index" do
    get moderator_requests_index_url
    assert_response :success
  end

  test "should get destroy" do
    get moderator_requests_destroy_url
    assert_response :success
  end

end
