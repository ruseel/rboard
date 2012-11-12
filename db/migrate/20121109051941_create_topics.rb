class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :admin_id
      t.string :subject
      t.text :body
      t.integer :boardish

      t.timestamps
    end
  end
end
