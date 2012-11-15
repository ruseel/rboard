require 'test_helper'

class TopicFlowTest < ActionDispatch::IntegrationTest
  test "topic create, show, edit, update" do
    get "topics/new"

    post_via_redirect "topics", :topic => { subject: "one", body: "one_body" }
    assert_equal 0, path =~ /\/topics\/([\d]+)/
    id = $1

    get "/topics/#{id}/edit"
    assert assigns(:topic)

    put_via_redirect "/topics/#{id}", :topic => { subject: "modified", body: "modified body" }
    assert_equal "/topics/#{id}", path
  end
end
