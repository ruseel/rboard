require 'test_helper'

module Rboard
  class TopicFlowTest < ActionDispatch::IntegrationTest
    setup do
      @board = rboard_boards(:one)
    end

    test "topic create, show, edit, update" do
      get new_board_topic_path(@board)

      post_via_redirect board_topics_path(@board), :topic => { subject: "one", body: "one_body" }
      path =~ /\/topics\/([\d]+)/
      id = $1

      get edit_topic_path(id)

      put_via_redirect board_topic_path(@board, id), :topic => { subject: "modified", body: "modified body" }
    end

    test "topic create and add one comment" do
      post_via_redirect board_topics_path(@board), :topic => { subject: "one", body: "one_body" }
      _path = path
      path =~ /\/topics\/([\d]+)/
      id = $1

      #post_via_redirect comments_path, topic_id: id, comment: { body: "comment" }
      #assert_equal _path, path
    end
  end
end