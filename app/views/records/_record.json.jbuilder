json.extract! record, :id, :internal_temp, :external_temp, :nest_temp, :nest_temp_high, :nest_temp_low, :created_at, :updated_at
json.url record_url(record, format: :json)
