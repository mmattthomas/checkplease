require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should get task" do
    get :task
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
