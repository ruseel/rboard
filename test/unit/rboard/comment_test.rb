require 'test_helper'

module Rboard
  class CommentTest < ActiveSupport::TestCase
    setup do
      @topic = topics(:one)
    end

    test "belongs_to topic" do
      c=Comment.new(body: "comment", topic: @topic)
      c.save
    end

    test "if not belongs_to topic, error" do
      c=Comment.new(body: "comment")
      assert_equal false, c.valid?
    end

    test "body should be presence" do
      c=Comment.create(body: "")
      assert_equal false, c.valid?
    end
  end
end