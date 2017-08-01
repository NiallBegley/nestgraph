class AddExternalHumidity < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :external_humidity, :float, :default => 0.0
  end
end
