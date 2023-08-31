class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :fullname
      t.string :email 
      t.integer :phone_number
      t.boolean :reschedule
      t.string :title

      t.timestamps
    end
  end
end
