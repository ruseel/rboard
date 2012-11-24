class CreateRboardComments < ActiveRecord::Migration
  def change
    create_table :rboard_comments do |t|
      t.string :topic_id
      t.text :body

      t.timestamps
    end
  end
end
