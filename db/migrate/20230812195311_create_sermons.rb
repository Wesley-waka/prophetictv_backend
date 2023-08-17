class CreateSermons < ActiveRecord::Migration[7.0]
  def change
    create_table :sermons do |t|
      t.string :title
      t.string :description
      t.string :video # This line adds the 'video' attribute
      t.boolean :downloaded
      t.integer :admin_id

      t.timestamps
    end
  end
end
