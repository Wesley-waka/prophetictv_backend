class CreateVideodownloads < ActiveRecord::Migration[7.0]
    def change
      create_table :videodownloads do |t|
        t.string :title
        t.string :description
        # t.string :video # This line adds the 'video' attribute
        t.boolean :downloaded
        t.string :speaker
        t.string :image
  
        t.timestamps
      end
    end
  end
  