class CreateChurches < ActiveRecord::Migration[7.0]
  def change
    create_table :churches do |t|
      t.string :churchname
      t.string :postalAddress
      

      t.timestamps
    end
  end
end
