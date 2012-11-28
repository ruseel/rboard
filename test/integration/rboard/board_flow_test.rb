require 'test_helper'

module Rboard
  class BoardFlowTest < ActionDispatch::IntegrationTest
    setup do
      @topic = rboard_topics(:one)
    end

    test "get url topics of boards(:one) " do
      get board_topics_path(rboard_boards(:one))
      assert_equal 1, assigns(:topics).size
    end
  end
end