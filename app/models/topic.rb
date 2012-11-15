class Topic < ActiveRecord::Base
  belongs_to :admin

  attr_accessor :parent_id

  attr_accessible :body, :subject, :parent
  before_save :set_boardish

  composed_of :boardish,
              class_name: "Boardish", mapping: [%w(boardish raw)],
              allow_nil: true,
              converter: :to_i

  default_scope { order("boardish desc") }

  def parent=(p)
    b = p.boardish.reply
    while (prev = self.class.where(boardish: b).first).present?
      b = b.inc_at_depth(b.depth)
    end
    self.boardish = b
  end

  def depth
    self.boardish && self.boardish.depth || 0
  end

private

  def set_boardish
    if self.boardish.nil?
      t = self.class.last_root_topic
      if t.nil? || t.boardish.nil?
        b = Boardish.new(nil)
      else
        b = t.boardish
      end
      self.boardish = b.inc_at_depth(0)
    end
  end

  class << self
    def last_root_topic
      Topic.limit(1).first
    end
  end
end
