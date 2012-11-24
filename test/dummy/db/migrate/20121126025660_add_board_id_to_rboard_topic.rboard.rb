# This migration comes from rboard (originally 20121121023435)
class AddBoardIdToRboardTopic < ActiveRecord::Migration
  def change
    add_column :rboard_topics, :board_id, :integer
  end
end
