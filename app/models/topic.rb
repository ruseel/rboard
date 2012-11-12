class Topic < ActiveRecord::Base
  belongs_to :admin

  attr_accessible :body, :subject

  before_save :set_boardish

private
  def set_boardish
    self.boardish = Boardish.new(largest_boardish).inc_at_depth(0)
  end

  def largest_boardish
    t = Topic.order("boardish desc").limit(1).first
    t && t.boardish
  end
end
