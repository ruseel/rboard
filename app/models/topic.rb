class Topic < ActiveRecord::Base
  belongs_to :admin

  attr_accessible :body, :subject, :parent

  before_save :set_boardish

  composed_of :boardish,
              class_name: "Boardish", mapping: [%w(boardish raw)],
              allow_nil: true,
              converter: :to_i

  default_scope { order("boardish desc") }

  def parent=(p)
    self.boardish = p.boardish.reply
  end

private

  def set_boardish
    if self.boardish.nil?
      t = self.class.last_root_topic
      self.boardish = (t ? t.boardish : Boardish.new(nil)).inc_at_depth(0)
    end
  end

  class << self
    def last_root_topic
      Topic.limit(1).first
    end
  end
end
