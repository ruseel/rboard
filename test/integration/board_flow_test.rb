require 'test_helper'

class BoardFlowTest < ActionDispatch::IntegrationTest
  test "boards/1/topics url" do
    get "/boards/1/topics"
  end
end
