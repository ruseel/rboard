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

  test "should show" do
    get :show, id: @topic
    assert_response :success
    assert_not_nil assigns(:topic)
    assert_not_nil assigns(:comment)
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:topic)
  end

  test "should get create" do
    assert_difference('Topic.count') do
      post :create, topic: { subject: @topic.subject, body: @topic.body }, parent_id: ""
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    put :update, id: @topic, topic: { body: @topic.body, subject: @topic.subject }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should get destroy" do
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
  end

  test "should handle reply" do
    post :create, topic: { subject: @topic.subject, body: @topic.body }
    parent = assigns(:topic)

    post :create, topic: { subject: "reply-1", body: "reply-1" }, parent_id: parent.id
    assert_equal parent.boardish.inc_at_depth(1), assigns(:topic).boardish
  end
end
