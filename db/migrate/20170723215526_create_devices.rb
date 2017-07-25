class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :name
      t.string :name_long
      t.boolean :is_online
      t.boolean :can_cool
      t.boolean :can_heat
      t.date :last_connection

      t.timestamps
    end
  end
end
