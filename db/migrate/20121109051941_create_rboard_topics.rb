class CreateRboardTopics < ActiveRecord::Migration
  def change
    create_table :rboard_topics do |t|
      t.integer :admin_id
      t.string :subject
      t.text :body
      t.integer :boardish

      t.timestamps
    end
  end
end
