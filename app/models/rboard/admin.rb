module Rboard
  class Admin < ActiveRecord::Base
    has_secure_password
    has_many :topics

    attr_accessible :email, :name, :password, :password_confirmation

    validates :email, :uniqueness => true
  end
end