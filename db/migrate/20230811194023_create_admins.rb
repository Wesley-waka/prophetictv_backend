class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :username
      t.integer :ministry_id, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
  end
end
