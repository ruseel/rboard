require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def admin
    @@admin ||= Admin.where(email: "a@a.com").first
  end

  test "create new topic" do
     t=Topic.new(subject: "a subject", body: "a body")
     t.admin=admin
     t.save

     assert_not_nil t.boardish
  end


  # test "create sub topic" do
  #   parent=Topic.new(subject: "parent topic", body: "parent topic")
  #   parent.admin = admin
  #   parent.save
  #
  #   children=Topic.new(subject: "children topic", body: "children topic", parent: parent)
  #   children.admin = admin
  #   children.save
  #
  #   assert_equal children.parent, parent
  #   assert_equal parent.child_ids, [children.id]
  # end
  #
  # test "list_order" do
  #   one=Topic.create(subject: "one", body: "one")
  #   two=Topic.create(subject: "two", body: "two")
  #   one_one=Topic.create(subject: "one_one", body: "one_one", parent: one)
  #   two_one=Topic.create(subject: "two_one", body: "two_one", parent: two)
  #
  #   subjects = Topic.sort_by_ancestry(:created_at).map(&:subject)
  #
  #   assert_equal ["two", "two_one", "one", "one_one"], subjects
  # end
end
