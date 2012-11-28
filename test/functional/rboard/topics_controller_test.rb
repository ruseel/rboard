require 'test_helper'

module Rboard
  class TopicsControllerTest < ActionController::TestCase
    setup do
      @topic = topics(:one)
      @board = boards(:one)

      # boardish value is not setted for fixture, so do it.
      @topic.boardish = Boardish.new
      @topic.save
    end

    test "should get index" do
      get :index, board_id: @board
      assert_response :success
      assert_not_nil assigns(:topics)
    end

    test "should show" do
      get :show, id: @topic, board_id: @board
      assert_response :success
      assert_not_nil assigns(:topic)
      assert_not_nil assigns(:comment)
      assert_not_nil assigns(:comments)
    end

    test "should get new" do
      get :new, board_id: @board
      assert_response :success
      assert_not_nil assigns(:topic)
    end

    test "should create topic" do
      assert_difference('Topic.count', 1) do
        post :create, board_id: @board, topic: { subject: @topic.subject, body: @topic.body }, parent_id: ""
      end

      assert_redirected_to board_topic_path(@board, assigns(:topic))
    end

    test "should get edit" do
      get :edit, id: @topic, board_id: @board
      assert_response :success
    end

    test "should update topic" do
      put :update, id: @topic, topic: { body: @topic.body, subject: @topic.subject }, board_id: @board
      assert_redirected_to board_topic_path(@board, assigns(:topic))
    end

    test "should destroy topic" do
      assert_difference('Topic.count', -1) do
        delete :destroy, id: @topic, board_id: @board
      end

      assert_redirected_to board_topics_path(@board)
    end

    test "should create reply" do
      reply = topics(:reply)
      post :create, topic: { subject: reply.subject, body: reply.body }, parent_id: @topic, board_id: @board
      assert_equal @board, assigns(:topic).board
      assert_equal @topic.boardish.inc_at_depth(1), assigns(:topic).boardish
    end
  end
end