class AddBoardIdToRboardTopic < ActiveRecord::Migration
  def change
    add_column :rboard_topics, :board_id, :integer
  end
end
