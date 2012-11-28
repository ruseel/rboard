require 'test_helper'

module Rboard
  class CommentsControllerTest < ActionController::TestCase
    setup do
      @board = rboard_boards(:one)
      @comment = rboard_comments(:one)
      @topic = rboard_topics(:one)
    end

    test "should show" do
      get :show, id: @comment
      assert_response :success
      assert_not_nil assigns(:comment)
    end

    test "should create comment" do
      assert_difference('Comment.count', 1) do
        post :create, comment: { body: "comment" }, topic_id: @topic
      end

      assert_redirected_to [@topic.board, @topic]
    end

    test "should show flash for empty body" do
      post :create, comment: {}, topic_id: @topic
      assert_equal "empty body", flash[:notice]
    end

    test "should get edit" do
      get :edit, id: @comment
      assert_response :success
    end

    test "should update comment" do
      put :update, id: @comment, comment: { body: @comment.body }
      assert_redirected_to @topic
    end

    test "should destroy comment" do
      assert_difference('Comment.count', -1) do
        delete :destroy, id: @comment
      end
      assert_redirected_to @topic
    end
  end
end