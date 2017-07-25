namespace :nestgraphing do
  task fetchdata: :environment do
    Device.all.each do |device|
      puts "Creating record for " + device.name

      device.create_new_record
    end
  end
end