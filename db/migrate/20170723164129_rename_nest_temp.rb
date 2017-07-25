class RenameNestTemp < ActiveRecord::Migration[5.1]
  def change
    rename_column :records, :nest_temp, :target_temp
  end
end
