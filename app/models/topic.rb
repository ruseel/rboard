class Topic < ActiveRecord::Base
  belongs_to :admin

  attr_accessible :body, :subject, :parent

  before_save :set_boardish

  def parent=(p)
    self.boardish = Boardish.new(p.boardish).reply.to_i
  end

private

  def set_boardish
    if self.boardish.nil?
      self.boardish = Boardish.new(largest_boardish).inc_at_depth(0).to_i
    end
  end

  def largest_boardish
    t = Topic.order("boardish desc").limit(1).first
    t && t.boardish
  end
end
