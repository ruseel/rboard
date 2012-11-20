class Comment < ActiveRecord::Base
  attr_accessible :body, :topic_id, :topic

  belongs_to :topic

  validates :body, presence: true
end
