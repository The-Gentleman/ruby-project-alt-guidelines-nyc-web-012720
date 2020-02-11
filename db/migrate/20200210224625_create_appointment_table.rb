class CreateAppointmentTable < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :dog_id
      t.integer :groomer_id
      t.string  :time
    end 
  end
end
