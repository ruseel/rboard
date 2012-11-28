require 'test_helper'

module Rboard
  class AdminTest < ActiveSupport::TestCase
    test "email could be registered only once" do
       Rboard::Admin.create(email: "a@a.com", password: "pw")
       _admin=Rboard::Admin.create(email: "a@a.com", password: "pw")
       assert_equal false, _admin.valid?
    end
  end
end