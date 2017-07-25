json.extract! device, :id, :device_id, :name, :name_long, :is_online, :can_cool, :can_heat, :last_connection, :created_at, :updated_at
json.url device_url(device, format: :json)
