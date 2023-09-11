class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :housename
      t.string :houselocation

      t.timestamps
    end
  end
end
