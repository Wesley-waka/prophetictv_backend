class CreatePrayers < ActiveRecord::Migration[7.0]
  def change
    create_table :prayers do |t|
      t.string :username
      t.string :email 
      t.string :title
      # t.integer :member_id

      t.timestamps
    end
  end
end
