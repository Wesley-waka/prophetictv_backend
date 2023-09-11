class CreateMinistries < ActiveRecord::Migration[7.0]
  def change
    create_table :ministries do |t|
      t.string :ministryname
      t.string :ministrylocation

      t.timestamps
    end
  end
end
