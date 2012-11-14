require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    assert_difference('Topic.count') do
      post :create, topic: { subject: @topic.subject, body: @topic.body }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should get destroy" do
    delete :destroy, id: @topic
    assert_response :success
  end

end
