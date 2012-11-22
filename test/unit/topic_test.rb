require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  setup do
    @topic = topics(:one)
    @board = boards(:one)
  end

  test "topic belongs to board" do
    Topic.create(subject: @topic.subject, body: @topic.body, board: @board)

    assert_equal 1, boards(:two).topics.count
  end

  test "create new topic without parent" do
    t=Topic.create(subject: "one", body: "one")
    assert_not_nil t.boardish
  end

  test "empty subject or empty body" do
    t=Topic.create(subject: "", body: @topic.body)
    assert_equal false, t.valid?
    assert_equal 2, t.errors[:subject].size

    t=Topic.create(subject: @topic.subject, body: "")
    assert_equal false, t.valid?
    assert_equal 0, t.errors[:subject].size
    assert_equal 1, t.errors[:body].size
  end

  test "subject length is too short" do
    t=Topic.create(subject: "a", body: @topic.body)
    assert_equal false, t.valid?
    assert t.errors[:subject].join(',').include?("is too short")
  end

  test "subject length is too long" do
    t=Topic.create(subject: "a"*51, body: @topic.body)
    assert_equal false, t.valid?
    assert t.errors[:subject].join(',').include?("is too long")
  end

  test "create sub topic" do
    parent=Topic.create(subject: "parent", body: "parent")
    children=Topic.create(subject: "children", body: "children", parent: parent)

    assert_equal children.boardish, parent.boardish.reply
  end

  test "two topic" do
    one=Topic.create(subject: "one", body: "one")
    two=Topic.create(subject: "two", body: "two")

    assert_equal one.boardish.inc_at_depth(0), two.boardish
  end

  test "ordered threads" do
    orig_subjects = Topic.all.map(&:subject)

    one=Topic.create(subject: "one", body: "one")
    one_one=Topic.create(subject: "one_one", body: "one_one", parent: one)
    two=Topic.create(subject: "two", body: "two")
    two_one=Topic.create(subject: "two_one", body: "two_one", parent: two)

    one_one_one=Topic.create(subject: "one_one_one", body: "one_one_one", parent: one_one)

    one_two=Topic.create(subject: "one_two", body: "one_two", parent: one)
    one_three=Topic.create(subject: "one_three", body: "one_three", parent: one)
    one_two_one=Topic.create(subject: "one_two_one", body: "one_two_one", parent: one_two)

    subjects = Topic.all.map(&:subject)
    assert_equal %w(two two_one one one_one one_one_one one_two one_two_one one_three) + orig_subjects, subjects
  end
end
