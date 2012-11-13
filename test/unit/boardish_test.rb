require 'test_helper'

class BoardishTest < ActiveSupport::TestCase
  test "create default boardish" do
    Boardish.new
    Boardish.new nil
  end

  test "create with different initializer" do
    Boardish.new(1)
    assert_equal Boardish.new(1,6), Boardish.new(1).inc_at_depth(1)
    assert_equal Boardish.new(1,6,6), Boardish.new(1).inc_at_depth(1).inc_at_depth(2)
  end

  test "from_int" do
    assert_equal Boardish.new(1, 6, 6), Boardish.from_int(Boardish.new(1, 6, 6).to_i)
    assert_equal Boardish.new(127, 6, 7), Boardish.from_int(Boardish.new(127, 6, 7).to_i)
  end

  test "increase at all depth" do
    (0...Boardish::DEPTH_SPEC.size).each do |i|
      Boardish.new.inc_at_depth i
    end
  end

  test "inc_at_depth should return another instance" do
    a = Boardish.new
    b = a.inc_at_depth(0)
    assert_not_equal a.object_id, b.object_id
  end

  test "current boardish depth" do
    assert_equal 0, Boardish.new.depth
    assert_equal 1, Boardish.new.inc_at_depth(1).depth
    assert_equal 2, Boardish.new.inc_at_depth(1).inc_at_depth(2).depth
  end

  test "reply" do
    assert_equal Boardish.new.inc_at_depth(1), Boardish.new.reply

    assert_equal 1, Boardish.new.reply.depth
    assert_equal 2, Boardish.new.reply.reply.depth
    assert_equal 2, Boardish.new.reply.reply.reply.depth
  end

  test "equality test" do
    assert_equal Boardish.new, Boardish.new
  end

  test "1,max 2,max should be ordered reverse" do
    sorted = boardish_sort [Boardish.new(1), Boardish.new(2)]
    assert_equal [Boardish.new(2), Boardish.new(1)], sorted
  end

  test "1,max 1,max-1 should be ordered as is" do
    first = Boardish.new(1)
    reply = first.inc_at_depth(1)
    assert_equal [first, reply], boardish_sort([first, reply])
  end

  test "2,max 2,max-1 1,max 1,max-1 should be ordered" do
    first = Boardish.new(1)
    first_reply = first.inc_at_depth(1)

    second = first.inc_at_depth(0)
    second_reply = second.inc_at_depth(1)

    assert_equal [second, second_reply, first, first_reply], boardish_sort([first,first_reply,second,second_reply])
  end

  test "1,max 1,max-1 1,max-1,max-1, 2,max 2,max-1 should be ordered" do
    first = Boardish.new(1)
    first_reply = first.inc_at_depth(1)
    first_reply_reply = first_reply.inc_at_depth(2)

    second = first.inc_at_depth(0)
    second_reply = second.inc_at_depth(1)

    assert_equal [second, second_reply, first, first_reply, first_reply_reply],
                  boardish_sort([first, first_reply, first_reply_reply, second, second_reply])
  end

  test "some wired" do
    assert_equal Boardish.from_int(Boardish.from_int(Boardish.new(1,7,7).to_i).reply.to_i), Boardish.new(1, 6, 7)
  end

private
  def boardish_sort(boardishs)
    boardishs.sort { |a,b| a.to_i <=> b.to_i } .reverse
  end
end
