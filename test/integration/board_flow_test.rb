require 'test_helper'

class BoardFlowTest < ActionDispatch::IntegrationTest
  test "get url topics of boards(:one) " do
    get board_topics_path(boards(:one))
    assert_equal 0, assigns(:topics).size
  end
end
