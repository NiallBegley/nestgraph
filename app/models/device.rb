class Device < ApplicationRecord
  validates :device_id, uniqueness: true

  def create_new_record
    nest = NestApi::Api.new

    api_device = nest.get_thermostat_by_name(self.name)

    record = Record.new

    
    record.device_id = api_device.get("device_id")
    record.humidity = api_device.get("humidity")
    record.internal_temp = api_device.get("ambient_temperature_f")

    if api_device.get("hvac_state").eql? "heating"
      record.is_heating = 60.0
    else
      record.is_heating = 0.0
    end

    record.time_to_target = api_device.get("time_to_target")
    record.name = api_device.get("name_long")
    record.target_temp = api_device.get("target_temperature_f")

    forecast = ForecastIO.forecast(ENV['FORECAST_IO_LATITUDE'].to_f, ENV['FORECAST_IO_LONGITUDE'].to_f)
    # ap forecast
    record.external_temp = forecast["currently"]["temperature"]

    record.external_humidity = forecast["currently"]["humidity"] * 100

    record.save

  end
  #has_many :records
end
