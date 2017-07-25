class AddHumidityAndState < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :hvac_state, :string
    add_column :records, :humidity, :float
    add_column :records, :name, :string
    add_column :records, :device_id, :string
    add_column :records, :time_to_target, :string
  end
end
