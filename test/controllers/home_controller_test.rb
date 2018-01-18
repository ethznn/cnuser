require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get board" do
    get :board
    assert_response :success
  end

  test "should get body" do
    get :body
    assert_response :success
  end

end
