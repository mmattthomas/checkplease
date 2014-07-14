require 'test_helper'

class TaskMasterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get make" do
    get :make
    assert_response :success
  end

end
