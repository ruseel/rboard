require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "belongs_to topic" do
    t=Topic.new(subject: "subject", body: "body")
    c=Comment.new(body: "comment")
    c.topic = t
    c.save
  end
end
