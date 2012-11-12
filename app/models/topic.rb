class Topic < ActiveRecord::Base
  belongs_to :admin

  attr_accessible :body, :subject

  #before_save :set_boardish

private
  def set_boardish
    self.boardish = Boardish.new(largest_boardish).next.to_i
  end

  def largest_boardish
    t = Topic.order("boardish desc").limit(1).first
    if t
      t.boardish
    else
      0
    end
  end
end
