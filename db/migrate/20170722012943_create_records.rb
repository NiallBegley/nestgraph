class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.float :internal_temp
      t.float :external_temp
      t.float :nest_temp
      t.float :nest_temp_high
      t.float :nest_temp_low

      t.timestamps
    end
  end
end
