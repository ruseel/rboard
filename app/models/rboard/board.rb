module Rboard
  class Board < ActiveRecord::Base
    attr_accessible :acronym, :description, :name

    has_many :topics
  end
end