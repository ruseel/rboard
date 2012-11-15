require 'test_helper'

class BoardishTest < ActiveSupport::TestCase
  def n(*args)
    Boardish.from_array args
  end

  test "create default boardish" do
    n
    n nil
    Boardish.from_int 0
    Boardish.from_int nil
  end

  test "create with different initializer" do
    n(1)
    assert_equal n(1,6), n(1).inc_at_depth(1)
    assert_equal n(1,6,6), n(1).inc_at_depth(1).inc_at_depth(2)
  end

  test "from_int" do
    assert_equal n(1, 6, 6), Boardish.from_int(n(1, 6, 6).to_i)
    assert_equal n(127, 6, 7), Boardish.from_int(n(127, 6, 7).to_i)
  end

  test "increase at all depth" do
    (0...Boardish::DEPTH_SPEC.size).each do |i|
      n.inc_at_depth i
    end
  end

  test "inc_at_depth should return another instance" do
    a = n
    b = a.inc_at_depth(0)
    assert_not_equal a.object_id, b.object_id
  end

  test "current boardish depth" do
    assert_equal 0, n.depth
    assert_equal 1, n.inc_at_depth(1).depth
    assert_equal 2, n.inc_at_depth(1).inc_at_depth(2).depth
  end

  test "reply" do
    assert_equal n.inc_at_depth(1), n.reply

    assert_equal 1, n.reply.depth
    assert_equal 2, n.reply.reply.depth
    assert_equal 2, n.reply.reply.reply.depth
  end

  test "equality test" do
    assert_equal n, n
  end

  test "1,max 2,max should be ordered reverse" do
    sorted = boardish_sort [n(1), n(2)]
    assert_equal [n(2), n(1)], sorted
  end

  test "1,max 1,max-1 should be ordered as is" do
    first = n(1)
    reply = first.inc_at_depth(1)
    assert_equal [first, reply], boardish_sort([first, reply])
  end

  test "2,max 2,max-1 1,max 1,max-1 should be ordered" do
    first = n(1)
    first_reply = first.inc_at_depth(1)

    second = first.inc_at_depth(0)
    second_reply = second.inc_at_depth(1)

    assert_equal [second, second_reply, first, first_reply], boardish_sort([first,first_reply,second,second_reply])
  end

  test "1,max 1,max-1 1,max-1,max-1, 2,max 2,max-1 should be ordered" do
    first = n(1)
    first_reply = first.inc_at_depth(1)
    first_reply_reply = first_reply.inc_at_depth(2)

    second = first.inc_at_depth(0)
    second_reply = second.inc_at_depth(1)

    assert_equal [second, second_reply, first, first_reply, first_reply_reply],
                  boardish_sort([first, first_reply, first_reply_reply, second, second_reply])
  end

  test "1, 1-1, 1-1-1, 1-2 should be ordered" do
    first = n(1)
    first_reply = first.inc_at_depth(1)
    first_reply_reply = first_reply.inc_at_depth(2)
  end

private
  def boardish_sort(boardishs)
    boardishs.sort { |a,b| a.to_i <=> b.to_i } .reverse
  end
end
