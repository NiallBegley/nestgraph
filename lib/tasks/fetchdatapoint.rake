namespace :nestgraphing do
  task fetchdata: :environment do
    Device.all.each do |device|
      puts "Creating record for " + device.name

      device.create_new_record
    end
  end

  task providecredentials: :environment do
    nest = NestApi::Api.new

    @remotedevices   =  nest.get_thermostat_list
  end
end