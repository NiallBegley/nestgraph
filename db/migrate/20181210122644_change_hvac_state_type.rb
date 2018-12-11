class ChangeHvacStateType < ActiveRecord::Migration[5.1]
  def change
    remove_column :records, :hvac_state
    add_column :records, :is_heating, :float, default: 0.0
  end
end
