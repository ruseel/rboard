require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "belongs_to topic" do
    t=Topic.new(subject: "subject", body: "body")
    c=Comment.new(body: "comment")
    c.topic = t
    c.save
  end

  test "body should be presence" do
    c=Comment.create(body: "")
    assert_equal false, c.valid?

  end
end
