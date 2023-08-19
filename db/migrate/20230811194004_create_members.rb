class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :email
      t.string :username
      # t.integer :church_id
      t.string :password_digest
      # t.string :password_confirmation

      t.timestamps
    end
  end
end
  