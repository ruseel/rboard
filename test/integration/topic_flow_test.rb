require 'test_helper'

class TopicFlowTest < ActionDispatch::IntegrationTest
  test "topic create, show, edit, update" do
    get new_topic_path

    post_via_redirect topics_path, :topic => { subject: "one", body: "one_body" }
    assert_equal 0, path =~ /\/topics\/([\d]+)/
    id = $1

    get edit_topic_path(id)
    assert assigns(:topic)

    put_via_redirect topic_path(id), :topic => { subject: "modified", body: "modified body" }
    assert_equal topic_path(id), path
  end

  test "topic create and add one comment" do
    post_via_redirect topics_path, :topic => { subject: "one", body: "one_body" }
    _path = path
    assert_equal 0, path =~ /\/topics\/([\d]+)/
    id = $1

    post_via_redirect comments_path, topic_id: id, comment: { body: "comment" }
    assert_equal _path, path
  end
end
