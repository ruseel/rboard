require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test "email could be registered only once" do
     Admin.create(email: "a@a.com", password: "pw")
     _admin=Admin.create(email: "a@a.com", password: "pw")
     assert_equal false, _admin.valid?
  end
end
