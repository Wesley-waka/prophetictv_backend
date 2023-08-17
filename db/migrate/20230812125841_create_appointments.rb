class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :first_name
      t.string :second_name
      t.string :email 
      t.integer :phone_number
      t.boolean :reschedule
      t.string :title
      # t.integer :member_id

      t.timestamps
    end
  end
end
