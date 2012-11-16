require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    @topic = topics(:one)
    # @comment.topic = @topic
    # @comment.save
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:comments)
  # end

  test "should show" do
    get :show, id: @comment
    assert_response :success
    assert_not_nil assigns(:comment)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should get create" do
    assert_difference('Comment.count', 1) do
      post :create, comment: { body: "comment" }, topic_id: @topic
    end

    assert_redirected_to @topic
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should get update" do
    put :update, id: @comment, comment: { body: "updated" }
    assert_redirected_to @topic
  end

  test "should get destroy" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment.id
    end
    assert_redirected_to @topic
  end

end
