module Rboard
  class Topic < ActiveRecord::Base
    belongs_to :board
    belongs_to :admin
    has_many :comments

    attr_accessible :body, :subject, :parent, :board
    before_save :set_boardish

    composed_of :boardish,
                class_name: "Boardish", mapping: [%w(boardish raw)],
                allow_nil: true,
                converter: :to_i

    validates :subject, presence: true, length: { minimum: 3, maximum: 50 }
    validates :body, presence: true

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
        b = t && t.boardish || Boardish.new
        self.boardish = b.inc_at_depth(0)
      end
    end

    class << self
      def last_root_topic
        Topic.limit(1).first
      end
    end
  end
end