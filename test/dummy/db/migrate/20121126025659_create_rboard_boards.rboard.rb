# This migration comes from rboard (originally 20121121022941)
class CreateRboardBoards < ActiveRecord::Migration
  def change
    create_table :rboard_boards do |t|
      t.string :name
      t.string :acronym
      t.text :description

      t.timestamps
    end
  end
end
