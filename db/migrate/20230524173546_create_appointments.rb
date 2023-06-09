class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.belongs_to :appointment
      t.string :text
      t.timestamps
    end

    create_table :appointments do |t|
      t.belongs_to :doctor
      t.belongs_to :patient
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
