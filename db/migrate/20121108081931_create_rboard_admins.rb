class CreateRboardAdmins < ActiveRecord::Migration
  def change
    create_table :rboard_admins do |t|
      t.string :email
      t.string :password_digest
      t.string :name

      t.timestamps
    end
  end
end
