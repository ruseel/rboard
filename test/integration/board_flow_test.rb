require 'test_helper'

class BoardFlowTest < ActionDispatch::IntegrationTest
  setup do
    @topic = topics(:one)
  end

  test "get url topics of boards(:one) " do
    get board_topics_path(boards(:one))
    assert_equal 0, assigns(:topics).size
  end
end
